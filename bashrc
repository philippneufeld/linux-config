#
# ~/.bashrc
#

# Check if shell is interactive
[[ $- != *i* ]] && return

# Bash completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Let local sudo processes access X Server
xhost +local:root > /dev/null 2>&1
complete -cf sudo

# Enable directory colors
if type -P dircolors >/dev/null ; then
  if [[ -f ~/.dir_colors ]] ; then
    eval $(dircolors -b ~/.dir_colors)
  elif [[ -f /etc/DIR_COLORS ]] ; then
    eval $(dircolors -b /etc/DIR_COLORS)
  fi
fi

# Enable colors for ls, etc.  
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

#
# PS1
#
set_ps1() {
	# check for virtual environment
	VENV=""
	[[ "$VIRTUAL_ENV" != "" ]] && VENV="($(basename "$VIRTUAL_ENV")) "

	# Distinguish Root and Non-Root (${EUID} == 0 indicates root)
	if [[ ${EUID} == 0 ]] ; then
		PS1="$VENV\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] "
	else
		PS1PREFIX="\[$(tput bold)\]\[$(tput setaf 1)\]["
		PS1USER="\[$(tput setaf 3)\]\u"
		PS1SEPARATOR="\[$(tput setaf 2)\]@"
		PS1HOST="\[$(tput setaf 4)\]\h"
		PS1DIRECTORY="\[$(tput setaf 5)\]\W"
		PS1SUFFIX="\[$(tput setaf 1)\]]"
		PS1CMDPREFIX="\[$(tput setaf 7)\]$ "
		PS1COLORRESET="\[$(tput sgr0)\]"

		PS1="$VENV$PS1PREFIX$PS1USER$PS1SEPARATOR$PS1HOST $PS1DIRECTORY$PS1SUFFIX$PS1CMDPREFIX$PS1COLORRESET"
	fi
}
# PROMPT_COMMAND is executed after each command
PROMPT_COMMAND="set_ps1"

# Shell options
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

# Aliases
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias more=less
alias vim=nvim
alias python=python3

