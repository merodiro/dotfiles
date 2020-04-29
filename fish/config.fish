source ~/.bash_aliases

set --universal fish_user_paths $fish_user_paths ~/.bin
set -gx EDITOR nvim
set -g theme_color_scheme "dracula"

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end


# auto start tmux when ssh 
if status --is-login
    set PPID (echo (ps --pid %self -o ppid --no-headers) | xargs)
    if ps --pid $PPID | grep ssh
        tmux has-session -t remote; and tmux attach-session -t remote; or tmux new-session -s remote; and kill %self
        echo "tmux failed to start; using plain fish shell"
    end
end
