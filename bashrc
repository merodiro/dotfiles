#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim=nvim
PS1='[\u@\h \W]\$ '

EDITOR=nvim
PATH="$PATH:$HOME/.config/composer/vendor/bin"
PATH="$PATH:$HOME/.yarn/bin"
PATH="$PATH:$HOME/.cargo/bin/"
# screenfetch
export GPG_TTY=$(tty)
