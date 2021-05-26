# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=all
HISTFILESIZE=all

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -f /etc/profile.d/bash_completion.sh ] && ! shopt -oq posix; then
	. /etc/profile.d/bash_completion.sh
fi

# personal stuff
export PATH=$PATH:$HOME/bin
export EDITOR=vim
export PYTHONSTARTUP=$HOME/.pystartup
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export WORKON_HOME=$HOME/environments

# setxkbmap -layout us -option ctrl:nocaps

if which brew &>/dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
    fi
fi

alias tclsh='rlwrap tclsh'
#if [ -f ~/bin/byobu.sh ];then
#   alias byobu='~/bin/byobu.sh'   # set up ssh-agent before starting byobu
#fi

export PATH=~/.local/bin:$PATH

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    . /usr/local/bin/virtualenvwrapper.sh
fi

if [ -n "$VIRTUAL_ENV" ]; then
    PS1="($(basename $VIRTUAL_ENV)) $PS1"
fi

export PATH=/usr/local:/usr/local/bin:$PATH
# virtualenv or pipenv
export VENV_TYPE=virtualenvwrapper


function project() {
    PROJECT=${1:-qa-dashboard}
    PROJECT_PATH="$HOME/src/git/$PROJECT"
	PROJECT_VENV="$WORKON_HOME/$PROJECT"

	if [ ! -d "$PROJECT_PATH" ]; then
		echo "Can't find project $PROJECT_PATH"
		return
	fi

	cd $PROJECT_PATH
	if [ "$VENV_TYPE" = "pipenv" ]; then
		pipenv shell
	else
		workon $PROJECT
	fi
}

function create_project() {
    PROJECT=${1:-qa-dashboard}
	shift
    PROJECT_PATH="$HOME/src/git/$PROJECT"
	PROJECT_VENV="$WORKON_HOME/$PROJECT"

	if [ ! -d "$PROJECT_PATH" ]; then
		echo "Can't find project $PROJECT_PATH"
		return
	fi

	if [ "$VENV_TYPE" = "pipenv" ]; then
		cd $PROJECT_PATH
		pipenv $@ install --dev
	else
		if [ ! -d "$PROJECT_VENV" ]; then
			mkvirtualenv $@ $PROJECT
		fi
	fi
}


# sources ~/.bash_local
LOCAL_BASHRC=$HOME/.bash_local
if [ -f $LOCAL_BASHRC ]; then
    . $LOCAL_BASHRC
fi

#ssh-add -l &>/dev/null || eval `ssh-agent` &>/dev/null  # start ssh-agent if not present
KEYCHAIN=/usr/bin/keychain
if [ -f "$KEYCHAIN" ]; then
	eval $(keychain --eval id_rsa)
fi

