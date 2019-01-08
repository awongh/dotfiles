
# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1
#
# # Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

set -o vi

#import all ur aliases
source $HOME/.bash_aliases

### vim key bindings
bindkey -v

bindkey '\e[3~' delete-char
#bindkey '^R' history-incremental-search-backward
#bindkey '^R' history-incremental-search-backward

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward
#
# # set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

export VISUAL=vim
export EDITOR="$VISUAL"


git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
export PATH=/usr/local/bin:$PATH
[[ -s ~/.bashrc ]] && source ~/.bashrc
