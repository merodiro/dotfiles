#!/bin/zsh
#
# __init__.zsh - Environment, PATH, and early plugin settings.
# Sourced first in conf.d/ due to __ prefix sort order.
#

# editors
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Android SDK
if [[ "$OSTYPE" == darwin* ]]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
else
  export ANDROID_HOME=$HOME/Android/Sdk
fi

# pnpm
export PNPM_HOME=$HOME/.local/share/pnpm

# PATH — (N) glob qualifier silently skips non-existent directories
path=(
  $HOME/.local/bin(N)
  $HOME/.cargo/bin(N)
  $HOME/go/bin(N)
  /usr/local/go/bin(N)
  $HOME/.yarn/bin(N)
  $HOME/.local/share/bob/nvim-bin(N)
  $HOME/.opencode/bin(N)
  $HOME/.cache/.bun/bin(N)
  $HOME/.kit/bin(N)
  $HOME/.deno/bin(N)
  $HOME/.meteor(N)
  $PNPM_HOME(N)
  $ANDROID_HOME/emulator(N)
  $ANDROID_HOME/tools(N)
  $ANDROID_HOME/tools/bin(N)
  $ANDROID_HOME/platform-tools(N)
  $path
)

# plugin settings — set before plugins source them
ZSH_AUTOSUGGEST_STRATEGY=(atuin history completion)

# used by atuin.zsh highlight fallback and zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#cba6f7,fg=#181825,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#f38ba8,fg=#181825,bold'
