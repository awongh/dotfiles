# Dot Files

## iTerm2 development workspace

Install iTerm2, Python 3, Neovim, and the Codex CLI, then install the workspace tools:

```sh
brew install tmux tmuxp
# If tmux -V reports a missing library:
brew reinstall tmux
```

Run the executable directly; no dotfiles installation is needed:

```sh
~/.dotfiles/scripts/dev                  # current directory
~/.dotfiles/scripts/dev ~/projects/app   # explicit project directory
```

The launcher activates iTerm2 and opens a new tab (or a window if none exists).
Inside it, tmuxp starts `nvim .` above `codex`, both in the project directory.
Edit `NVIM_PERCENT=65` and `CODEX_PERCENT=35` at the top of `scripts/dev` to
change their heights. Both must be positive integers totaling 100. Actual
heights are rounded to terminal rows, allowing space for the divider.

Each canonical directory has its own persistent tmux session. Running again
opens another tab attached to that session, preserving programs and layout;
ratio changes affect newly created sessions. Different tabs attached to the
same session share its panes. Exit an application to return to its pane's shell.
Detach with tmux's default **Ctrl+b, then d**; running the launcher again
reattaches. To rebuild with new percentages, first save your work and end the
old session with `tmux kill-session -t SESSION_NAME` (`tmux list-sessions` lists
names). This terminates its applications.

The new tab uses a login zsh and needs all tools available on its PATH.
macOS may ask permission for your terminal to control iTerm2; allow it in
System Settings → Privacy & Security → Automation. The existing tmux config
is used, including any custom prefix key. The `scripts` directory is excluded
from the Rake installer's automatic home-directory symlinks.

Run the launcher regression checks without opening iTerm2:

```sh
python3 scripts/test_dev.py
```

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive.

```terminal
git clone git://github.com/awongh/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake install
```

After installing, open a new terminal window to see the effects.

Feel free to customize the .zshrc file to match your preference.

## Uninstall

To remove the dotfile configs, run the following commands. Be certain to double check the contents of the files before removing so you don't lose custom settings.

```
unlink ~/.bin
unlink ~/.gitignore
unlink ~/.gemrc
unlink ~/.gvimrc
unlink ~/.irbrc
unlink ~/.vim
unlink ~/.vimrc
rm ~/.zshrc # careful here
rm ~/.gitconfig
rm -rf ~/.dotfiles
rm -rf ~/.oh-my-zsh
chsh -s /bin/bash # change back to Bash if you want
```

Then open a new terminal window to see the effects.

# clojure

Clojure lein profile from here: http://jakemccrary.com/blog/2015/01/11/overview-of-my-leiningen-profiles-dot-clj/

# git prompt:

 #### * unstaged changes
 #### + staged changes

 In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
 unstaged * and staged (+) changes will be shown next to the branch
 name.  You can configure this per-repository with the
 bash.showDirtyState variable, which defaults to true once
 GIT_PS1_SHOWDIRTYSTATE is enabled.

 #### $ stashed

 You can also see if currently something is stashed, by setting
 GIT_PS1_SHOWSTASHSTATE to a nonempty value. If something is stashed,
 then a '$' will be shown next to the branch name.

 #### % untracked files

 If you would like to see if there're untracked files, then you can set
 GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're untracked
 files, then a '%' will be shown next to the branch name.  You can
 configure this per-repository with the bash.showUntrackedFiles
 variable, which defaults to true once GIT_PS1_SHOWUNTRACKEDFILES is
 enabled.

 #### > behind head
 #### <> diverged head
 #### = up to date with head

 If you would like to see the difference between HEAD and its upstream,
 set GIT_PS1_SHOWUPSTREAM="auto".  A "<" indicates you are behind, ">"
 indicates you are ahead, "<>" indicates you have diverged and "="
 indicates that there is no difference.


# New System Setup (mac)

chrome
iterm

set non admin user to sudo: https://zwbetz.com/add-your-account-as-a-sudoer-on-mac/

change login shell:
https://www.howtogeek.com/444596/how-to-change-the-default-shell-to-bash-in-macos-catalina/
chsh -s /bin/bash

xcode cli tools

homebrew

brew install tmux

#### rbenv

rbenv

rbenv init
rbenv install <RUBY VERSION>
rbenv global <RUBY VERSION>

eval "$(rbenv init -)"
echo $PATH

```
gem install bundler
```

nvm

dotfiles

vim install plugins

karabiner keyboard remapper

unix pass manager

better touch tool

postgres.app

vscode?





## Neovim (0.12.6+)

The Lua configuration lives in `config/nvim`. Install just its symlink safely:

```sh
cd ~/.dotfiles
rake install_neovim
nvm use 24
nvim
```

`rake install` also installs this mapping. Both link only `~/.config/nvim`,
leaving other applications in `~/.config` alone. A conflicting Neovim config
is backed up beside its original location only after confirmation. Correct
links are left alone. The older Vim configuration remains separate.

Node is managed by nvm; Node 22 and 24 are already installed. Use Node 24 for
initial setup. Neovim inherits Node/npm from its launching shell; respect project
`.nvmrc` files and restart Neovim after `nvm use` to pick up the new PATH.
No Homebrew Node installation or change to the nvm default is required.
Ruby LSP also needs a compatible Ruby with RubyGems available (this machine has
Ruby 3.4.1 through rbenv). Its project bundle can impose additional requirements.
Keep `git`, `curl`, archive tools, and `ripgrep` available on PATH.

### Packages and language servers

The six editor plugins are installed by native `vim.pack` on first launch.
Accept the initial installation prompt. The generated
`config/nvim/nvim-pack-lock.json` belongs in Git alongside the Lua config;
plugin checkouts, Mason executables, caches, and logs live in Neovim's standard
user data/state/cache directories instead.

Update plugins explicitly:

```vim
:lua vim.pack.update()
```

Review the update buffer, write it to accept or quit to reject, then restart
Neovim. Review and commit the resulting lockfile changes with the config.

Mason installs external **language-server programs**, separately from vim.pack's
editor plugins. The configured servers are Lua (`lua_ls`), JS/TS/React (`ts_ls`),
Python (`pyright`), and Ruby (`ruby_lsp`). Installation is asynchronous; wait for
completion in `:Mason`, then reopen the file or restart Neovim. For headless
installation, use `:MasonInstall lua-language-server typescript-language-server pyright ruby-lsp`;
Mason's automatic ensure-installed step runs in interactive sessions.
Server versions are managed by Mason and are not pinned by the plugin lockfile.

For problems, inspect `:Mason`, `:MasonLog`, `:checkhealth mason`,
`:checkhealth telescope`, and `:checkhealth vim.lsp`. Check `:!node --version`
and `:!npm --version` if npm-based server installation fails. Missing server
executables or incompatible project Ruby dependencies should be fixed before
expecting LSP attachment. A fresh install needs network access.

### Navigation and editing

Space is the leader key. The tree opens for `nvim .`, but not an ordinary file
or empty launch. Telescope searches the working directory, includes hidden
files, respects ignore rules, and excludes `.git`.

- Space+n: toggle tree; Space+j: reveal current file.
- Space+ff: files; Space+fg: project text; Space+fb: buffers; Space+fh: help.
- `gd`: definition; `K`: hover; `grn`: rename; `grr`: references; `gra`: code actions.
- `[d` / `]d`: previous/next diagnostic; Space+d: diagnostic details.
- Space+f: format through the attached server, when supported; no format-on-save.
- Ctrl+Space: request native LSP completion; Ctrl+n / Ctrl+p: select; Ctrl+y: accept.
- Escape: clear search highlighting.

Completion also opens on server-provided trigger characters; it does not promise
suggestions after every keystroke. Some terminals intercept Ctrl+Space; native
Ctrl+x Ctrl+o is an alternative. Diagnostics use signs and underlines rather
than inline text. File icons do not require a patched font.

### Validation

Run the installer regression checks without touching your home directory:

```sh
ruby config/nvim/tests/installer_test.rb
```

The initial setup was also checked in isolated Neovim data directories: tree
startup/toggle behavior, all four Telescope pickers, Mason installation, and LSP
attachment, symbols, hover, completion, definitions, and diagnostics. JS/TS and
Python server requests were exercised under both nvm Node 24 and Node 22.
Health checks may report missing optional runtimes (PHP, Julia, LuaRocks) or
`fd`; those are not dependencies of this configuration.
