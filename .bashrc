#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

HISTCONTROL=ignoreboth
export EDITOR=nvim
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.yarn/bin"
PATH="$PATH:$HOME/.cargo/bin/"
PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.deno/bin"

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

eval "$(starship init bash)"
. "$HOME/.cargo/env"

eval "$(mise activate bash)"

