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
		# PS1="$VENV\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] "
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
alias np='nano -w PKGBUILD'
alias more=less
alias vim=nvim

# ssh mount of the pi5 computer
alias mountpi5='sshfs pi5:./ ~/pi5/'
alias umountpi5='fusermount -u ~/pi5/'

# Uni vpn
connect_uni_vpn() {
    if [[ $(command -v pass) ]] && [[ $(command -v /opt/cisco/anyconnect/bin/vpn) ]]; then
        UNI_CAMPUS_PASS=$(pass uni-stuttgart/campus 2> /dev/null)
        if ! [[ -z "$UNI_CAMPUS_PASS)" ]]; then
            UNI_CAMPUS_PASSWORD=$(echo "$UNI_CAMPUS_PASS" | head -1)
            UNI_CAMPUS_LOGIN=$(echo "$UNI_CAMPUS_PASS" | grep "login:" | sed "s/login:[ ]*//g")
            UNI_CAMPUS_LOGIN_PASSWORD=$(echo -e "${UNI_CAMPUS_LOGIN}\n${UNI_CAMPUS_PASSWORD}")
            echo "$UNI_CAMPUS_LOGIN_PASSWORD" | /opt/cisco/anyconnect/bin/vpn -s connect "vpn.tik.uni-stuttgart.de"
        else
            echo "Please add a pass entry uni-stuttgart/campus containing the password and the login name"
        fi
        UNI_CAMPUS_PASS=""
        UNI_CAMPUS_PASSWORD=""
        UNI_CAMPUS_LOGIN=""
        UNI_CAMPUS_LOGIN_PASSWORD=""
    else
        echo "This command requires pass and cisco anyconnect to be installed"
    fi
}

disconnect_uni_vpn() {
    if [[ $(command -v /opt/cisco/anyconnect/bin/vpn) ]]; then
        /opt/cisco/anyconnect/bin/vpn -s disconnect vpn.tik.uni-stuttgart.de
    else
        echo "This command requires cisco-anyconnect to be installed"
    fi
}

alias uni-vpn-connect=connect_uni_vpn
alias uni-vpn-disconnect=disconnect_uni_vpn

if [[ "$HOSTNAME" == "ludwigsburg" ]] ; then
    if [[ -f ~/.bash_scripts/labapps.sh ]] ; then
        source ~/.bash_scripts/labapps.sh
        alias lockapp="launch_lock_app"
        alias tgscontrol="launch_tgscontrol_app"
    fi
    
    alias meas="cd $HOME/TGS/Measurements/$(date '+%Y')"
    alias meas_today="cd $HOME/TGS/Measurements/$(date '+%Y')/$(date '+%Y-%m-%d')"
fi

# Open dolphin at current directory
alias dolph="\$(nohup dolphin . &>/dev/null &)"

