# alias sudo='sudo env PATH=$PATH'

uberg(){
	foo="grep --color=always --exclude-dir=\\*i18n\\* --exclude-dir=\\*.svn\\* --exclude-dir=\\*smarty_compiled\\* --exclude-dir=\\*log\\* --exclude=\\*min.js\\* --exclude=\\*cscope.out\\* --exclude=\\*tmp\\* -A2 -C2 -Rni \"$1\" ."

	echo ${foo}

	eval "${foo}"

	res=$?

	echo $1
	return ${res}
}

alias vimswapclean='find . -name *.swp -name *.swo -name *.swn -exec rm -i '{}' \;'

alias gitpushcheck='git log --branches --not --remotes'

# alias passwords='gpg -d ~/.passwords.gpg'

alias tmux-pair='tmux attach-session -t pair'

printcolumns(){
  local __cols=$(tput cols)
  echo $((__cols - 10))
}
