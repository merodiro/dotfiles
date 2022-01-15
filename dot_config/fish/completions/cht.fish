# register completions (on-the-fly, non-cached, because the actual command won't be cached anyway
complete -c cht -xa '(curl -s cheat.sh/:list)'
