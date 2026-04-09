#
# antidote: The fastest Zsh plugin manager.
#

# Setup antidote.
export ZSH_CUSTOM=${ZSH_CUSTOM:-$ZDOTDIR}
export ANTIDOTE_HOME=${ANTIDOTE_HOME:-${XDG_CACHE_HOME:-$HOME/.cache}/repos}

# Clone antidote if missing.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Lazy-load antidote from its functions directory.
fpath=(${ZDOTDIR:-$HOME}/.antidote/functions $fpath)
autoload -Uz antidote

# Generate static file in a subshell whenever .zsh_plugins.txt is updated.
zplugins=${ZDOTDIR:-~}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]] || [[ ! -e $ANTIDOTE_HOME/.lastupdated ]]; then
  antidote bundle <${zplugins} >|${zplugins}.zsh
  date +%Y-%m-%dT%H:%M:%S%z >| $ANTIDOTE_HOME/.lastupdated
fi

# Source the static file.
source ${zplugins}.zsh
