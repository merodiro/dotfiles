# fnox: auto-load project secrets (GITHUB_TOKEN, etc.) when entering a project.
#
# Two gotchas this guards against:
# 1. Ordering — conf.d is sourced alphabetically, so this runs before
#    mise.zsh and mise shims aren't on PATH yet. Prepend them if needed.
# 2. Cold start — a shell opened directly inside a project never fires the
#    chpwd hook, so the first command would miss secrets. Trigger one load.

if (( ! $+commands[fnox] )) && [[ -d $HOME/.local/share/mise/shims ]]; then
  path=($HOME/.local/share/mise/shims $path)
fi
(( $+commands[fnox] )) || return

# Silent: hook prints "fnox: +N secrets" on every directory change otherwise.
export FNOX_SHELL_OUTPUT=none

if (( $+functions[cached-eval] )); then
  cached-eval 'fnox-activate-zsh' fnox activate zsh
else
  eval "$(fnox activate zsh)"
fi

# Warm the current directory: no chpwd fires for the dir we started in.
if (( $+functions[_fnox_hook] )); then
  _fnox_hook
fi
