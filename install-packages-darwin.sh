#!/bin/bash

brew bundle --no-lock --file=/dev/stdin <<EOF
brew "bat"
brew "cheat"
brew "exa"
brew "fzf"
brew "gh"
brew "jq"
brew "ripgrep"
brew "starship"
brew "zellij"
brew "zoxide"
cask "iterm2"
EOF

