# mise
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  eval "$($HOME/.local/bin/mise activate bash --shims)"
elif; then
  eval "$($HOME/.local/bin/mise activate bash)"
fi
