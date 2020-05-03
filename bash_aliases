# navigation
alias ..='cd ..'
alias ...='cd ../..'

# vim
alias vim=nvim

# Changing "ls" to "exa"
alias ls='exa --color=always --group-directories-first' # my preferred listing
alias la='ls -a'  # all files and dirs
alias ll='ls -alF'  # long format
alias lt='ls -aT' # tree listing

# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# termbin
alias tb="nc termbin.com 9999"

