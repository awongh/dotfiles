# Dot Files

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





