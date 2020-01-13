#!/usr/bin/env bash

function install_required_packages() {
  sudo add-apt-repository -y ppa:ultradvorka/ppa
  sudo apt-get update
  sudo apt-get install -y hstr git xclip
}

function timer_start {
  timer=${timer:-$SECONDS}
}

function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

trap 'timer_start' DEBUG

if [ "$PROMPT_COMMAND" == "" ]; then
  PROMPT_COMMAND="timer_stop"
else
  PROMPT_COMMAND="$PROMPT_COMMAND; timer_stop"
fi

PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] [\${timer_show}s]:\[\033[01;34m\]\w\[\033[00m\]\$ "

#PS1='\[\e]0;\u@\h: \w\a\] [last: ${timer_show}s][\w]$ '

DOTFILES_DIR=$(dirname "$BASH_SOURCE")
export PATH=$PATH:$DOTFILES_DIR/bin

# Force per-repository git configs
git config --global user.useConfigOnly false

# Enable Autojump
. ${DOTFILES_DIR}/autojump/autojump.bash

# Use hstr for searching bash history
## Whenever a command is executed, write it to a global history
PROMPT_COMMAND="history -a ~/.bash_history.global; $PROMPT_COMMAND"
## Remap CTRL-r
bind -x '"\C-r": "HISTFILE=~/.bash_history.global hh"'

# aliases for easy copy/paste from terminal
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export EDITOR=vim

alias makej='make -j $(nproc)'

# Assume virtual environments in the current directory
export VIRTUAL_ENV=.venv
