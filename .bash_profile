#
# ~/.bash_profile
#

# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/bash_profile.pre.bash"

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"

export PATH="$HOME/.local/share/mise/shims:$PATH"

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/bash_profile.post.bash"
