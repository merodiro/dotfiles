#!/bin/sh
set -e

# Install chezmoi and apply dotfiles
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply merodiro

# Install mise if not already installed
if ! command -v mise > /dev/null && ! [ -x "$HOME/.local/bin/mise" ]; then
    curl https://mise.run | sh
fi

# Install all tools defined in mise config
"$HOME/.local/bin/mise" install

# Re-apply now that tools are installed (updates templated configs)
chezmoi apply
