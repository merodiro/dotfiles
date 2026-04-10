#!/bin/zsh
#
# completions.zsh - Auto-generate completions for tools that support it.
# Completions are cached in $ZSH_CACHE_DIR/completions/ and regenerated
# when the tool binary is newer than the cached completion file.
#

if (( $+commands[usage] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_usage" || "$commands[usage]" -nt "$ZSH_CACHE_DIR/completions/_usage" ]]; then
    usage --completions zsh >| "$ZSH_CACHE_DIR/completions/_usage" &|
  fi
fi

if (( $+commands[atuin] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_atuin" || "$commands[atuin]" -nt "$ZSH_CACHE_DIR/completions/_atuin" ]]; then
    atuin gen-completions --shell zsh >| "$ZSH_CACHE_DIR/completions/_atuin" &|
  fi
fi

if (( $+commands[pnpm] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_pnpm" || "$commands[pnpm]" -nt "$ZSH_CACHE_DIR/completions/_pnpm" ]]; then
    pnpm completion zsh >| "$ZSH_CACHE_DIR/completions/_pnpm" &|
  fi
fi

if (( $+commands[mise] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_mise" || "$commands[mise]" -nt "$ZSH_CACHE_DIR/completions/_mise" ]]; then
    mise completion zsh >| "$ZSH_CACHE_DIR/completions/_mise" &|
  fi
fi

if (( $+commands[fnox] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_fnox" || "$commands[fnox]" -nt "$ZSH_CACHE_DIR/completions/_fnox" ]]; then
    fnox completion zsh >| "$ZSH_CACHE_DIR/completions/_fnox" &|
  fi
fi

if (( $+commands[starship] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_starship" || "$commands[starship]" -nt "$ZSH_CACHE_DIR/completions/_starship" ]]; then
    starship completions zsh >| "$ZSH_CACHE_DIR/completions/_starship" &|
  fi
fi

if (( $+commands[bob] )); then
  if [[ ! -f "$ZSH_CACHE_DIR/completions/_bob" || "$commands[bob]" -nt "$ZSH_CACHE_DIR/completions/_bob" ]]; then
    bob complete zsh >| "$ZSH_CACHE_DIR/completions/_bob" &|
  fi
fi

