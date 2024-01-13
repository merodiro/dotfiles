#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'fnm' command can not be found
if ! (( $+commands[fnm] )); then
    echo "ERROR: 'fnm' command not found"
    return
fi

# Add 'fnm' environment variables for 'zsh'
# Add hook to change Node version on change directory
eval "$(fnm env --shell zsh --use-on-cd)"

