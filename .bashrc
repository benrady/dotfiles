#!/usr/bin/env bash

function install_required_packages() {
  sudo add-apt-repository -y ppa:ultradvorka/ppa
  sudo apt-get update
  sudo apt-get install -y hstr
}

DOTFILES_DIR=$(dirname "$BASH_SOURCE")
export PATH=$PATH:$DOTFILES_DIR/bin

# Force per-repository git configs
git config --global user.useConfigOnly false

# Enable Autojump
. ${DOTFILES_DIR}/autojump/autojump.bash

# Enable vi mode
set -o vi

# Use hstr for searching bash history
## Whenever a command is executed, write it to a global history
PROMPT_COMMAND="history -a ~/.bash_history.global; $PROMPT_COMMAND"
## Remap CTRL-r
bind -x '"\C-r": "HISTFILE=~/.bash_history.global hh"'

# aliases for easy copy/paste from terminal
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

export EDITOR=vim
