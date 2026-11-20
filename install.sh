#!/bin/sh
set -e

# Install chezmoi and apply dotfiles (writes ~/.config/mise/config.toml)
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply merodiro

# Install mise if not already installed
if ! command -v mise > /dev/null && ! [ -x "$HOME/.local/bin/mise" ]; then
    curl https://mise.run | sh
fi

# Provision the machine: packages, login shell, and tools from mise config
"$HOME/.local/bin/mise" bootstrap --yes --update

# Re-apply now that tools are installed (updates templated configs)
chezmoi apply
