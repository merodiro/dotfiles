#!/bin/sh
set -e

# Install chezmoi if not already installed
if ! command -v chezmoi > /dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
fi

# Apply dotfiles
chezmoi init --apply merodiro/dotfiles

# Install mise if not already installed
if ! command -v mise > /dev/null && ! [ -x "$HOME/.local/bin/mise" ]; then
    curl https://mise.run | sh
fi

# Install all tools defined in mise config
"$HOME/.local/bin/mise" install

# Re-apply now that tools are installed (updates templated configs)
chezmoi apply
