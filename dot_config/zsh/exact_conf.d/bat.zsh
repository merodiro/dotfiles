if ! (( $+commands[bat] )); then return; fi

alias cat='bat --paging=never'
alias less='bat'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
