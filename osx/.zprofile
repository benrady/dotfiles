autoload -U colors && colors

# Function to extract the current Git branch
function parse_git_branch() {
  git branch 2> /dev/null | sed -n '/^\* /s/^* \(.*\)/ (\1)/p'
}

function preexec() {
  timer=${timer:-$SECONDS}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    unset timer
  else
    timer_show=0
  fi
  PS1="%F{blue}%n %F{green}%~%F{red}$(parse_git_branch) %F{cyan}[${timer_show}s]%F{white}%#%f "
}

export PS1

# Makefile autocomplete
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets' 'variables'
autoload -U compinit && compinit
