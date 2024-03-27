#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

export PATH="$HOME/.local/share/mise/shims:$PATH"
