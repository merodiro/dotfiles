(( $+commands[zoxide] )) || return 1

if (( $+functions[cached-eval] )); then
  cached-eval 'zoxide-init-zsh' zoxide init zsh
else
  eval "$(zoxide init zsh)"
fi
