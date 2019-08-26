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
#bindkey '^R' history-incremental-search-backward

# Search backwards and forwards with a pattern
# bindkey -M vicmd '/' history-incremental-pattern-search-backward
# bindkey -M vicmd '?' history-incremental-pattern-search-forward
#
# # set up for insert mode too
# bindkey -M viins '^R' history-incremental-pattern-search-backward
# bindkey -M viins '^F' history-incremental-pattern-search-forward

export VISUAL=vim
export EDITOR="$VISUAL"


git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit"
export PATH=/usr/local/bin:$PATH

##################################################################
##################################################################
#                                                               #
#                                                               #
#                                                               #
#               START PROMPT STUFF                              #
#                                                               #
#                                                               #
#                                                               #
##################################################################
##################################################################
##################################################################
##################################################################
##################################################################
##################################################################


# Sexy Solarized Bash Prompt, inspired by "Extravagant Zsh Prompt"
# Customized for the Solarized color scheme by Sean O'Neil

# from: https://gist.github.com/yuri91/4af6ac59fe7d31dd91fb


if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then TERM=gnome-256color; fi
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      BASE03=$(tput setaf 234)
      BASE02=$(tput setaf 235)
      BASE01=$(tput setaf 240)
      BASE00=$(tput setaf 241)
      BASE0=$(tput setaf 244)
      BASE1=$(tput setaf 245)
      BASE2=$(tput setaf 254)
      BASE3=$(tput setaf 230)
      YELLOW=$(tput setaf 136)
      ORANGE=$(tput setaf 166)
      RED=$(tput setaf 160)
      MAGENTA=$(tput setaf 125)
      VIOLET=$(tput setaf 61)
      BLUE=$(tput setaf 33)
      CYAN=$(tput setaf 37)
      GREEN=$(tput setaf 64)
    else
      BASE03=$(tput setaf 8)
      BASE02=$(tput setaf 0)
      BASE01=$(tput setaf 10)
      BASE00=$(tput setaf 11)
      BASE0=$(tput setaf 12)
      BASE1=$(tput setaf 14)
      BASE2=$(tput setaf 7)
      BASE3=$(tput setaf 15)
      YELLOW=$(tput setaf 3)
      ORANGE=$(tput setaf 9)
      RED=$(tput setaf 1)
      MAGENTA=$(tput setaf 5)
      VIOLET=$(tput setaf 13)
      BLUE=$(tput setaf 4)
      CYAN=$(tput setaf 6)
      GREEN=$(tput setaf 2)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    # Linux console colors. I don't have the energy
    # to figure out the Solarized values
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi

# FROM: https://digitalfortress.tech/tutorial/setting-up-git-prompt-step-by-step/
#export PS1="\[\033[38;5;2m\]\H\[$(tput sgr0)\]\[\033[38;5;15m\]\n
#\u @ \h \[$(tput sgr0)\]"
function color_my_prompt {
  local __reset="$RESET"
  local __user="$YELLOW\u"
  local __host="$BASE0\h"
  local __separate="$YELLOW|"
  local __cur_location="$BLUE\w"           # capital 'W': current directory, small 'w': full file path
  local __git_branch_color="$GREEN"
  local __att="$CYAN@"
  local __user_input_color="$BASE1"
  local __git_branch='$(__git_ps1)';
  local __bold='$(tput bold)'


#if [[ $LC_CTYPE =~ '\.[Uu][Tt][Ff]-?8' ]]; then
  if [[ "$(locale charmap)" = "UTF-8" ]]; then

    local __prompt_tail=$'‣'
  else
    local __prompt_tail="$BASE1~"
  fi

  # colour branch name depending on state
  if [[ "$(__git_ps1)" =~ "*" ]]; then     # if repository is dirty
      __git_branch_color="$RESET$RED"
  elif [[ "$(__git_ps1)" =~ "$" ]]; then   # if there is something stashed
      __git_branch_color="$RESET$YELLOW"
  elif [[ "$(__git_ps1)" =~ "%" ]]; then   # if there are only untracked files
      __git_branch_color="$RESET$BASE2"
  elif [[ "$(__git_ps1)" =~ "+" ]]; then   # if there are staged files
      __git_branch_color="$RESET$CYAN"
  fi

  HAHA="$__reset$__bold$__user$__reset$__bold$__att$__reset$__bold$__host$__reset$__bold$__separate$__reset$__bold$__cur_location\n"
  BANANA="$__reset$__prompt_tail$__reset$__user_input_color"

  # Create a string like:  "[ Apr 25 16:06 ]" with time in RED.
  printf -v PS1RHS "$__git_branch_color$__git_branch"

  # Strip ANSI commands before counting length
  # From: https://www.commandlinefu.com/commands/view/12043/remove-color-special-escape-ansi-codes-from-text-with-sed
  PS1RHS_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$PS1RHS")
  HAHA_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$HAHA")
  BANANA_stripped=$(sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" <<<"$BANANA")

  # Reference: https://en.wikipedia.org/wiki/ANSI_escape_code
  local Save='\e[s' # Save cursor position
  local Rest='\e[u' # Restore cursor to save point

  # Save cursor position, jump to right hand edge, then go left N columns where
  # N is the length of the printable RHS string. Print the RHS string, then
  # return to the saved position and print the LHS prompt.

  # Note: "\[" and "\]" are used so that bash can calculate the number of
  # printed characters so that the prompt doesn't do strange things when
  # editing the entered text.

  PS1="\[${Save}\e[${COLUMNS:-$(tput cols)}C\e[${#PS1RHS}D${PS1RHS}${Rest}\]\[${HAHA_stripped}\]\[${BANANA_stripped}\]"
}

# configure PROMPT_COMMAND which is executed each time before PS1
export PROMPT_COMMAND=color_my_prompt
# git prompt script from git: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
# if .git-prompt.sh exists, set options and execute it
if [ -f ~/.git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  . ~/.git-prompt.sh
fi

##################################################################
##################################################################
#                                                               #
#                                                               #
#                                                               #
#               END PROMPT STUFF                                #
#                                                               #
#                                                               #
#                                                               #
##################################################################
##################################################################
##################################################################
##################################################################
##################################################################
##################################################################

export PIP_REQUIRE_VIRTUALENV=true

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
