if ! (( $+commands[eza] )); then return; fi

alias ls='eza --group-directories-first --icons=auto'
alias ll='ls -lh --git'
alias la='ll -a'
alias lt='ll --tree --level=2'
