(( $+commands[fzf] )) || return

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# FZF_CTRL_R_COMMAND is cleared so atuin handles Ctrl-R instead
FZF_CTRL_R_COMMAND=

if (( $+functions[cached-eval] )); then
  cached-eval 'fzf-init-zsh' fzf --zsh
else
  source <(fzf --zsh)
fi
