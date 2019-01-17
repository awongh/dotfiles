# Ryan Bates Dot Files

These are config files to set up a system the way I like it. It now uses [Oh My ZSH](https://github.com/robbyrussell/oh-my-zsh). If you would like to see my old, custom Bash and ZSH config, check out [this branch](https://github.com/ryanb/dotfiles/tree/custom-bash-zsh)

I am running on Mac OS X, but it will likely work on Linux as well.


## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the [Rakefile](https://github.com/ryanb/dotfiles/blob/custom-bash-zsh/Rakefile) to see exactly what it does.

```terminal
git clone git://github.com/ryanb/dotfiles ~/.dotfiles
cd ~/.dotfiles
rake install
```

After installing, open a new terminal window to see the effects.

Feel free to customize the .zshrc file to match your preference.


## Features

Many of the following features are added through the "rbates" Oh My ZSH plugin.

I normally place all of my coding projects in ~/code, so this directory can easily be accessed (and tab completed) with the "c" command.

```terminal
c railsca<tab>
```

There is also an "h" command which behaves similar, but acts on the home path.

```terminal
h doc<tab>
```

Tab completion is also added to rake and cap commands:

```
rake db:mi<tab>
cap de<tab>
```

To speed things up, the results are cached in local .rake_tasks~ and .cap_tasks~. It is smart enough to expire the cache automatically in most cases, but you can simply remove the files to flush the cache.

If you're using git, you'll notice the current branch name shows up in the prompt while in a git repository.

There are several features enabled in Ruby's irb including history and completion. Many convenience methods are added as well such as "ri" which can be used to get inline documentation in IRB. See irbrc file for details.


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

Clojure lein profile from here: http://jakemccrary.com/blog/2015/01/11/overview-of-my-leiningen-profiles-dot-clj/

### todo:
 - add this to env:
```
HOMEBREW_BUILD_FROM_SOURCE=1
HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_NO_EMOJI=1
HOMEBREW_NO_ANALYTICS=1
```

### git prompt:

 #### * unstaged changes
 #### + staged changes

 In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
 unstaged (*) and staged (+) changes will be shown next to the branch
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

