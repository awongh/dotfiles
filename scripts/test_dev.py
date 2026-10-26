"""Launcher regression checks; stubs never open iTerm or start applications."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).with_name('dev').resolve()


class LauncherTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        self.bin = self.root / 'bin'
        self.bin.mkdir()
        self.env = dict(os.environ, PATH=f'{self.bin}:' + os.environ['PATH'],
                        TEST_ROOT=str(self.root), TMUX='nested-client')
        self.stub('tmux', '''#!/bin/sh
case "$1" in
  -V) exit 0 ;;
  has-session) test -f "$TEST_ROOT/session" ;;
  attach-session) printf '%s' "$3" > "$TEST_ROOT/attached"
    test -z "${TMUX:-}" ;;
esac
''')
        self.stub('tmuxp', '''#!/usr/bin/env python3
import json, os, pathlib, sys
root = pathlib.Path(os.environ['TEST_ROOT'])
workspace = json.loads(pathlib.Path(sys.argv[3]).read_text())
workspace['start_directory'] = os.path.expandvars(workspace['start_directory'])
(root / 'workspace.json').write_text(json.dumps(workspace))
(root / 'temp-path').write_text(sys.argv[3])
(root / 'session').touch()
''')
        for tool in ('nvim', 'codex'):
            self.stub(tool, '#!/bin/sh\nexit 0\n')
        self.stub('osascript', '''#!/bin/sh
printf '%s' "$2" > "$TEST_ROOT/command"
cat > "$TEST_ROOT/applescript"
''')

    def stub(self, name, content):
        path = self.bin / name
        path.write_text(content)
        path.chmod(0o755)

    def run_dev(self, *args, script=SCRIPT):
        return subprocess.run(['/bin/zsh', str(script), *map(str, args)],
                              env=self.env, text=True, capture_output=True)

    def test_create_reuse_and_quoting(self):
        project = self.root / "a space ' quote $HOME `ticks` ; app"
        project.mkdir()
        result = self.run_dev(project)
        self.assertEqual(result.returncode, 0, result.stderr)
        command = (self.root / 'command').read_text()
        # Round-trip both shell boundaries, substituting a harmless argv printer.
        capture = self.root / 'capture'
        capture.write_text('#!/bin/zsh\nprintf "%s\\0" "$@"')
        capture.chmod(0o755)
        command = command.replace(str(SCRIPT), str(capture))
        # Avoid login startup files while retaining the generated shell quoting.
        command = command.replace('/bin/zsh -lic ', '/bin/zsh -fc ', 1)
        quoted = subprocess.run(['/bin/zsh', '-fc', command], capture_output=True)
        self.assertEqual(quoted.stdout.split(b'\0')[:2],
                         [b'--attach', os.fsencode(project)])
        result = self.run_dev('--attach', project)
        self.assertEqual(result.returncode, 0, result.stderr)
        workspace = json.loads((self.root / 'workspace.json').read_text())
        self.assertEqual(workspace['start_directory'], str(project))
        window = workspace['windows'][0]
        self.assertEqual(window['options']['main-pane-height'], '65%')
        self.assertEqual(window['panes'][0]['shell_command'], ['nvim .'])
        self.assertEqual(window['panes'][1]['shell_command'], ['codex'])
        self.assertFalse(Path((self.root / 'temp-path').read_text()).exists())
        (self.root / 'workspace.json').unlink()
        alias = self.root / 'alias'
        alias.symlink_to(project)
        self.assertEqual(self.run_dev('--attach', alias).returncode, 0)
        self.assertFalse((self.root / 'workspace.json').exists())
        self.assertEqual((self.root / 'attached').read_text(), '=' + workspace['session_name'])

    def test_same_basename_different_sessions(self):
        names = []
        for parent in ('one', 'two'):
            project = self.root / parent / 'app'
            project.mkdir(parents=True)
            (self.root / 'session').unlink(missing_ok=True)
            self.assertEqual(self.run_dev('--attach', project).returncode, 0)
            names.append(json.loads((self.root / 'workspace.json').read_text())['session_name'])
        self.assertNotEqual(*names)

    def test_errors_and_ratio(self):
        self.assertNotEqual(self.run_dev(self.root / 'missing').returncode, 0)
        self.stub('tmux', '#!/bin/sh\nexit 1\n')
        self.assertIn('brew reinstall tmux', self.run_dev(self.root).stderr)
        changed = self.root / 'dev'
        changed.write_text(SCRIPT.read_text().replace('NVIM_PERCENT=65', 'NVIM_PERCENT=70'))
        self.assertIn('totaling 100', self.run_dev(self.root, script=changed).stderr)
        changed.write_text(SCRIPT.read_text().replace('NVIM_PERCENT=65', 'NVIM_PERCENT=oops'))
        self.assertIn('must be integers', self.run_dev(self.root, script=changed).stderr)
        (self.bin / 'tmuxp').unlink()
        self.env['PATH'] = str(self.bin)
        self.assertIn('missing tmuxp', self.run_dev(self.root).stderr)

    def test_changed_ratio(self):
        changed = self.root / 'dev'
        changed.write_text(SCRIPT.read_text().replace('NVIM_PERCENT=65', 'NVIM_PERCENT=70')
                           .replace('CODEX_PERCENT=35', 'CODEX_PERCENT=30'))
        result = self.run_dev('--attach', self.root, script=changed)
        self.assertEqual(result.returncode, 0, result.stderr)
        workspace = json.loads((self.root / 'workspace.json').read_text())
        self.assertEqual(workspace['windows'][0]['options']['main-pane-height'], '70%')


if __name__ == '__main__':
    unittest.main()
