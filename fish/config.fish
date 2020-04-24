source ~/.bash_aliases

set --universal fish_user_paths $fish_user_paths ~/.bin
set -gx EDITOR nvim
set -g theme_color_scheme "nord"

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end
