(( $+commands[brew] )) || return

if (( $+functions[cached-eval] )); then
  cached-eval 'brew-shellenv' brew shellenv
else
  eval "$(brew shellenv)"
fi
