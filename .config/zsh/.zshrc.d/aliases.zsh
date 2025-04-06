#!/bin/zsh
#
# .aliases - Set whatever shell aliases you want.
#

# single character aliases - be sparing!
alias _=sudo
alias l=ls
alias g=git

# navigation
alias ..='cd ..'
alias ...='cd ../..'

# mask built-ins with better defaults
alias vi=vim
alias vim=nvim

# more ways to ls
alias ll='ls -lAh' # long format
alias la='ls -A' # all files and dirs
alias lt='ls -aT' # tree listing
alias ldot='ls -ld .*' # dotfiles

# fix common typos
alias quit='exit'
alias cd..='cd ..'

# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# url encode/decode
alias urldecode='python3 -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as ul; \
    print (ul.quote_plus(sys.argv[1]))"'

# misc
alias please=sudo
alias zshrc='${EDITOR:-vim} "${ZDOTDIR:-$HOME}"/.zshrc'
alias zbench='for i in {1..10}; do /usr/bin/time zsh -lic exit; done'
alias zdot='cd ${ZDOTDIR:-~}'

# termbin
alias tb="nc termbin.com 9999"

# bat
alias cat='bat --paging=never'
