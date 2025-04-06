# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=nvim

# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Source anything in .zshrc.d.
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

# To customize prompt, run `p10k configure` or edit .p10k.zsh.
[[ ! -f ${ZDOTDIR:-$HOME}/.p10k.zsh ]] || source ${ZDOTDIR:-$HOME}/.p10k.zsh

# # Created by Zap installer
# [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# plug "zap-zsh/supercharge"
# plug "zap-zsh/exa"
# plug "zap-zsh/completions"

# plug "zsh-users/zsh-autosuggestions"
# plug "zsh-users/zsh-syntax-highlighting"
# plug "zsh-users/zsh-completions"
# plug "zsh-users/zsh-history-substring-search"

# eval "$(starship init zsh)"

system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
elif [ "$system_type" = "Darwin" ]; then
  export ANDROID_HOME=$HOME/Android/Sdk
fi

PATH=$PATH:$ANDROID_HOME/emulator
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH="$HOME/.yarn/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.local/bin/:$PATH"
PATH="$HOME/.bin:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.kit/bin:$PATH"
PATH="$HOME/.deno/bin:$PATH"
PATH="$HOME/.local/share/bob/nvim-bin/:$PATH"
PATH="/usr/local/go/bin:$PATH"

fpath+=~/.config/zsh/completions/

autoload -Uz compinit && compinit


. "$HOME/.cargo/env"

fast-theme XDG:catppuccin-mocha --quiet

eval "$(rbenv init - zsh)"
eval "$(mise activate zsh)"
