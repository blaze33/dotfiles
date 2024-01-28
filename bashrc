# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export LC_ALL=C.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=300000
HISTFILESIZE=9000000
HISTTIMEFORMAT=`echo -e "\033[1;34m%F \033[1;31m%T%z \033[0m "`

# append to the history file, don't overwrite it
shopt -s histappend
# export PROMPT_COMMAND='history -a; history -n;history 1 >> ${HOME}/.bash_eternal_history'
export PROMPT_COMMAND='history -n; history -w; history -c; history -r; history 1 >> ${HOME}/.bash_eternal_history;'

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

# #virtualenvwrapper config
# export WORKON_HOME="$HOME/.virtualenvs"
# source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
# # virtualenv aliases
# # http://blog.doughellmann.com/2010/01/virtualenvwrapper-tips-and-tricks.html
# alias v='workon'
# alias v.deactivate='deactivate'
# alias v.mk='mkvirtualenv --no-site-packages'
# alias v.mk_withsitepackages='mkvirtualenv'
# alias v.rm='rmvirtualenv'
# alias v.switch='workon'
# alias v.add2virtualenv='add2virtualenv'
# alias v.cdsitepackages='cdsitepackages'
# alias v.cd='cdvirtualenv'
# alias v.lssitepackages='lssitepackages'
# complete -o default -o nospace -F _virtualenvs v
# venv config
export VENV_HOME=~/.venvs
export VENV_PYTHON=/usr/bin/python3
source ~/github/dotfiles/virtualenvwrapper-venv-aliases.sh


alias gedit='LANG=en_US gedit'
alias tmux="tmux -2"
alias gti="git"

# Ensure git speaks english
alias git='LANG=en_US git'
# Ensure meld doesn't crash when git speaks english
alias meld='LC_ALL=en_US.utf8 meld'

# use ddccontrol to configure an external screen, works for LG IPS236
lcd-setup() {
    sudo modprobe i2c-dev
    sudo chmod a+rw /dev/i2c-*
    export DDC_DEVICE=`LC_ALL=C ddccontrol -p | grep Device: | awk '{ print $3 }'`
    echo $DDC_DEVICE
}
alias lcd-off='ddccontrol -r 0xd6 $DDC_DEVICE -w 4'
alias lcd-lum='ddccontrol -r 0x10 $DDC_DEVICE -w'
alias lcd-con='ddccontrol -r 0x12 $DDC_DEVICE -w'
alias dodo="sudo uname;lcd-off; sudo pm-hibernate;"

# todo-list t alias
alias t='python ~/bin/t/t.py --task-dir ~/Dropbox/tasks --list tasks'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Add pip3 user packages
export PATH="/home/maxime/.local/bin:$PATH"

# Load tmuxinator
export EDITOR='vim'
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
alias mux="TERM=xterm-256color mux"

PATH=$HOME/bin:$PATH # Add user bin folder

alias remove-git-cola-translation="sudo mv /usr/share/locale/fr/LC_MESSAGES/git-cola.mo /usr/share/locale/fr/LC_MESSAGES/git-cola.mo_"

# rvm wants to be at the end to be the first in path
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm # Load RVM into a shell session *as a function*
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set color bash prompt according to active virtualenv, git branch,
# mercurial branch and return status of last command.
# https://gist.github.com/2484714
source ~/.bash_prompt

# cf. https://github.com/direnv/direnv#bash
eval "$(direnv hook bash)"

# recursive glob http://unix.stackexchange.com/a/49917/3547
shopt -s globstar

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
