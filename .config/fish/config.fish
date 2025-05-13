source ~/.bash_aliases

set -gx EDITOR nvim

# auto start tmux when ssh
# or use https://unix.stackexchange.com/questions/121807/how-to-use-booleans-in-fish-shell
if status --is-login
    set PPID (echo (ps --pid %self -o ppid --no-headers) | xargs)
    if ps --pid $PPID | grep ssh
        tmux has-session -t remote; and tmux attach-session -t remote; or tmux new-session -s remote; and kill %self
        echo "tmux failed to start; using plain fish shell"
    end
end
