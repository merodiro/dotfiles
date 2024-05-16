# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=nvim

# # Created by Zap installer
# [ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# plug "zap-zsh/supercharge"
# plug "zap-zsh/exa"
# plug "zap-zsh/completions"

# plug "zsh-users/zsh-autosuggestions"
# plug "zsh-users/zsh-syntax-highlighting"
# plug "zsh-users/zsh-completions"
# plug "zsh-users/zsh-history-substring-search"
# plug "$HOME/.zsh/plugins/zsh-fnm.plugin.zsh"

# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-$HOME}/.zsh/.zsh_plugins

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins}.txt ]]; then
  (antidote bundle <${zsh_plugins}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

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
PATH="$HOME/.fnm:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.kit/bin:$PATH"
PATH="$HOME/.deno/bin:$PATH"
PATH="$HOME/.local/share/bob/nvim-bin/:$PATH"
PATH="/usr/local/go/bin:$PATH"
source ~/.bash_aliases


# history size
HISTSIZE=5000
HISTFILESIZE=10000

SAVEHIST=5000
setopt EXTENDED_HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS

fpath+=~/.zsh/.zfunc

autoload -Uz compinit && compinit


. "$HOME/.cargo/env"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"
# Bun completions
[ -s "/home/amr/.bun/_bun" ] && source "/home/amr/.bun/_bun"

# Bun
export BUN_INSTALL="/home/amr/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bind up and down to history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

eval "$(fnm env --shell zsh --use-on-cd)"

# Switch nvim config https://gist.github.com/elijahmanor/b279553c0132bfad7eae23e34ceb593b
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

function nvims() {
  items=("default" "NvChad" "LazyVim" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

zsh-defer fast-theme XDG:catppuccin-mocha --quiet

eval "$(~/.local/bin/mise activate zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(rbenv init - zsh)"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
