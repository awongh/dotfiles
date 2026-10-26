"""Launcher behavior with stub tmux commands; no apps are opened."""
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
        self.env = dict(os.environ, PATH=f'{self.bin}:' + os.environ['PATH'], TEST_ROOT=str(self.root))
        self.env.pop('TMUX', None)
        self.env.pop('TMUX_PANE', None)
        self.stub('tmux', '''#!/bin/sh
printf '%s\\n' "$*" >> "$TEST_ROOT/tmux.log"
case "$1" in
  -V) exit 0 ;;
  has-session) test -f "$TEST_ROOT/session" ;;
  new-session) touch "$TEST_ROOT/session" ;;
  new-window) printf '@2' ;;
  list-windows) test -f "$TEST_ROOT/session" && printf '@1 editor\\n' ;;
  list-panes) if test -f "$TEST_ROOT/ready"; then
      printf 'exec /path/to/nvim .\\nexec /path/to/codex\\n'
    else
      printf '/bin/zsh\\n'
    fi ;;
  display-message) case "$*" in *window_id*) printf '@1' ;; *) printf '%%9' ;; esac ;;
  split-window) test "${TEST_SPLIT_FAIL:-0}" = 0 ;;
  respawn-pane) touch "$TEST_ROOT/ready" ;;
  attach-session) test -z "${TMUX:-}" ;;
esac
''')
        for tool in ('nvim', 'codex'):
            self.stub(tool, '#!/bin/sh\nexit 0\n')

    def stub(self, name, content):
        path = self.bin / name
        path.write_text(content)
        path.chmod(0o755)

    def run_dev(self, *args, script=SCRIPT):
        return subprocess.run(['/bin/zsh', str(script), *map(str, args)],
                              env=self.env, text=True, capture_output=True)

    def commands(self):
        return (self.root / 'tmux.log').read_text().splitlines()

    def test_outside_tmux_creates_split_and_reuses_it(self):
        project = self.root / "a space ' quote $HOME `ticks` ; app"
        project.mkdir()
        result = self.run_dev(project)
        self.assertEqual(result.returncode, 0, result.stderr)
        commands = self.commands()
        self.assertTrue(any(line.startswith('new-session') for line in commands))
        self.assertTrue(any('main-pane-height 65%' in line for line in commands))
        self.assertTrue(any('split-window' in line and str(self.bin / 'codex') in line for line in commands))
        self.assertTrue(any('respawn-pane' in line and str(self.bin / 'nvim') in line for line in commands))
        self.assertTrue(any(line.startswith('attach-session') for line in commands))
        first_count = sum('split-window' in line for line in commands)
        alias = self.root / 'alias'
        alias.symlink_to(project)
        self.assertEqual(self.run_dev(alias).returncode, 0)
        self.assertEqual(sum('split-window' in line for line in self.commands()), first_count)

    def test_inside_tmux_splits_original_pane(self):
        self.env.update(TMUX='/tmp/socket,123,0', TMUX_PANE='%9')
        result = self.run_dev(self.root)
        self.assertEqual(result.returncode, 0, result.stderr)
        commands = self.commands()
        self.assertTrue(any(line.startswith('split-window') and ' -l 35% -t %9 ' in line
                            for line in commands))
        self.assertTrue(any(line.startswith('respawn-pane') and ' -t %9 ' in line
                            for line in commands))
        self.assertFalse(any('attach-session' in line for line in commands))
        self.assertFalse(any('new-session' in line for line in commands))

    def test_failed_split_leaves_pane_running(self):
        self.env.update(TMUX='/tmp/socket,123,0', TMUX_PANE='%9', TEST_SPLIT_FAIL='1')
        self.assertIn('could not split', self.run_dev(self.root).stderr)
        self.assertFalse(any('respawn-pane' in line for line in self.commands()))

    def test_invalid_ratio_and_directory(self):
        self.assertNotEqual(self.run_dev(self.root / 'missing').returncode, 0)
        changed = self.root / 'dev'
        changed.write_text(SCRIPT.read_text().replace('NVIM_PERCENT=65', 'NVIM_PERCENT=70'))
        self.assertIn('totaling 100', self.run_dev(self.root, script=changed).stderr)
        changed.write_text(SCRIPT.read_text().replace('NVIM_PERCENT=65', 'NVIM_PERCENT=oops'))
        self.assertIn('must be integers', self.run_dev(self.root, script=changed).stderr)


if __name__ == '__main__':
    unittest.main()
