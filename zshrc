# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1
#
# # Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

set -o vi

#import all ur aliases
source $HOME/.bash_aliases

### vim key bindings
# bindkey -v

# bindkey '\e[3~' delete-char
#bindkey '^R' history-incremental-search-backward

# Search backwards and forwards with a pattern
# bindkey -M vicmd '/' history-incremental-pattern-search-backward
# bindkey -M vicmd '?' history-incremental-pattern-search-forward
#
# # set up for insert mode too
# bindkey -M viins '^R' history-incremental-pattern-search-backward
# bindkey -M viins '^F' history-incremental-pattern-search-forward
#


##################################################################
##################################################################
#              HISTORY
# https://github.com/squidfunk/dotfiles/blob/master/shell/history.zsh
##################################################################
##################################################################
bindkey '^R' history-incremental-search-backward
export HIST_STAMPS="dd.mm.yy"


# History configuration
if [ -z "$HISTFILE" ]; then
  HISTFILE=$HOME/.zsh_history
fi

# Size of history
HISTSIZE=10000
SAVEHIST=10000

# Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac

# Configuration
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt interactivecomments

##################################################################
#              END HISTORY
##################################################################

export VISUAL=vim
export EDITOR="$VISUAL"


git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
export PATH=/usr/local/bin:$PATH

##################################################################
##################################################################
##########    prmopt                 #############################
##################################################################
##################################################################



# ***************************************************************
# ******************* git              **************************
# ***************************************************************

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )

# Enable substitution in the prompt.
setopt prompt_subst

zstyle ':vcs_info:git:*' formats '%b'

# Config for the prompt. PS1 synonym.
PROMPT="%h:%n:%d👉 "

#rprompt='${vcs_info_msg_0_}> '
#prompt='%2/ ${vcs_info_msg_0_}> '
RPROMPT='${vcs_info_msg_0_}'

# ***************************************************************


##################################################################
##################################################################
##################################################################
##################################################################
##################################################################

# for zshell, get all the paths from bashrc
[[ -s ~/.bashrc ]] && source ~/.bashrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ${HOME}/.ghcup/env

# pnpm
export PNPM_HOME="/Users/akira/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/bin/env"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/akira/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# java / android / react native paths
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH
export PATH="/usr/local/opt/openjdk@17/bin:$PATH"

export SSH_AUTH_SOCK=/Users/akira/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
