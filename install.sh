#!/bin/sh
set -e

install_zsh() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                if ! command -v zsh > /dev/null; then
                    export DEBIAN_FRONTEND=noninteractive
                    sudo apt-get update -qq
                    sudo apt-get install -y -qq zsh
                fi
                if [ "$SHELL" != "$(command -v zsh)" ]; then
                    sudo chsh -s "$(command -v zsh)" "$USER"
                fi
                ;;
        esac
    fi
}

install_zsh

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
