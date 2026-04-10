(( $+commands[wt] )) || return

if (( $+functions[cached-eval] )); then
  cached-eval 'wt-init-zsh' wt config shell init zsh
else
  eval "$(wt config shell init zsh)"
fi
