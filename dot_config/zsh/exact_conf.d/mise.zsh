(( $+commands[mise] )) || return

if (( $+functions[cached-eval] )); then
  cached-eval 'mise-activate-zsh' mise activate zsh
else
  eval "$(mise activate zsh)"
fi
