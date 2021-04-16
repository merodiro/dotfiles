source ~/.zsh/antigen.zsh

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export EDITOR=nvim


antigen use oh-my-zsh
antigen bundle git
antigen bundle git-extras
antigen bundle archlinux
antigen bundle npm
antigen bundle python
antigen bundle pip
antigen bundle sudo
antigen bundle yarn

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

eval "$(starship init zsh)"

antigen apply


ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
PATH="$HOME/.yarn/bin:$PATH"
PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.local/bin/:$PATH"
PATH="$HOME/.bin:$PATH"

eval "$(fnm env)"
# eval "$(fnm completions --shell zsh)"

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
