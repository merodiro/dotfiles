if ! command -v atuin >/dev/null 2>&1; then return; fi

if (( $+functions[cached-eval] )); then
  cached-eval 'atuin-init-zsh' atuin init zsh --disable-up-arrow
else
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# Reference: https://gist.github.com/tyalie/7e13cfe2ec62d99fa341a07ed12ef7c0
# But modified to include syntax highlighting of the search query

#----------------------------------
# main
#----------------------------------

# global configuration
: ${ATUIN_HISTORY_SEARCH_FILTER_MODE='global'}
: ${ATUIN_HISTORY_HIGHLIGHT_FOUND=${HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND:-'bg=magenta,fg=white,bold'}}

# internal variables
typeset -g -i _atuin_history_match_index
typeset -g _atuin_history_search_result
typeset -g _atuin_history_search_query
typeset -g _atuin_history_refresh_display

atuin-history-up() {
  _atuin-history-search-begin

  # iteratively use the next mechanism to process up if the previous didn't succeed
  _atuin-history-up-buffer ||
  _atuin-history-up-search

  _atuin-history-search-end
}

atuin-history-down() {
  _atuin-history-search-begin

  # iteratively use the next mechanism to process down if the previous didn't succeed
  _atuin-history-down-buffer ||
  _atuin-history-down-search ||
  zle _atuin_search_widget

  _atuin-history-search-end
}

zle -N atuin-history-up
zle -N atuin-history-down

bindkey '\eOA' atuin-history-up
bindkey '\eOB' atuin-history-down

#-----------END main---------------

#----------------------------------
# implementation details
#----------------------------------

_atuin-history-search-begin() {
  # assume we will not render anything
  _atuin_history_refresh_display=

  # If the buffer is the same as the previously displayed history substring
  # search result, then just keep stepping through the match list. Otherwise
  # start a new search.
  if [[ -n $BUFFER && $BUFFER == ${_atuin_history_search_result:-} ]]; then
    return;
  fi

  # Clear the previous result.
  _atuin_history_search_result=''

  # setup our search query
  if [[ -z $BUFFER ]]; then
    _atuin_history_search_query=
  else
    _atuin_history_search_query="$BUFFER"
  fi

  # reset search index
  _atuin_history_match_index=0
}

_atuin-history-search-end() {
  # if our index is <= 0 just print the query we started with
  if [[ $_atuin_history_match_index -le 0 ]]; then
    _atuin_history_search_result="$_atuin_history_search_query"
  fi

  # draw buffer if requested
  if [[ $_atuin_history_refresh_display -eq 1 ]]; then
    BUFFER="$_atuin_history_search_result"
    CURSOR="${#BUFFER}"
  fi

  # highlight matched query within the buffer
  # clear all region_highlight so stale fast-syntax-highlighting entries don't linger;
  # fast-syntax-highlighting re-runs after this widget and will re-add its own highlights
  region_highlight=()
  if [[ -n $_atuin_history_search_query && $_atuin_history_match_index -gt 0 ]]; then
    local lower_buffer="${(L)BUFFER}"
    local lower_query="${(L)_atuin_history_search_query}"
    local before="${lower_buffer%%${lower_query}*}"
    if [[ ${#before} -lt ${#lower_buffer} ]]; then
      # exact phrase found — highlight it as one span
      local match_start=${#before}
      local match_end=$(( match_start + ${#_atuin_history_search_query} ))
      region_highlight+=("$match_start $match_end $ATUIN_HISTORY_HIGHLIGHT_FOUND memo=atuin-history-search")
    else
      # no exact phrase — highlight each word individually
      local word
      for word in ${=lower_query}; do
        before="${lower_buffer%%${word}*}"
        if [[ ${#before} -lt ${#lower_buffer} ]]; then
          local match_start=${#before}
          local match_end=$(( match_start + ${#word} ))
          region_highlight+=("$match_start $match_end $ATUIN_HISTORY_HIGHLIGHT_FOUND memo=atuin-history-search")
        fi
      done
    fi
  fi

  # for debug purposes only
  #zle -R "mn: "$_atuin_history_match_index" / qr: $_atuin_history_search_result"
  #read -k -t 1 && zle -U $REPLY

}

_atuin-history-up-buffer() {
  # attribution to zsh-history-substring-search
  #
  # Check if the UP arrow was pressed to move the cursor within a multi-line
  # buffer. This amounts to three tests:
  #
  # 1. $#buflines -gt 1.
  #
  # 2. $CURSOR -ne $#BUFFER.
  #
  # 3. Check if we are on the first line of the current multi-line buffer.
  #    If so, pressing UP would amount to leaving the multi-line buffer.
  #
  #    We check this by adding an extra "x" to $LBUFFER, which makes
  #    sure that xlbuflines is always equal to the number of lines
  #    until $CURSOR (including the line with the cursor on it).
  #
  local buflines XLBUFFER xlbuflines
  buflines=(${(f)BUFFER})
  XLBUFFER=$LBUFFER"x"
  xlbuflines=(${(f)XLBUFFER})

  if [[ $#buflines -gt 1 && $CURSOR -ne $#BUFFER && $#xlbuflines -ne 1 ]]; then
    zle up-line-or-history
    return 0
  fi

  return 1
}

_atuin-history-down-buffer() {
  # attribution to zsh-history-substring-search
  #
  # Check if the DOWN arrow was pressed to move the cursor within a multi-line
  # buffer. This amounts to three tests:
  #
  # 1. $#buflines -gt 1.
  #
  # 2. $CURSOR -ne $#BUFFER.
  #
  # 3. Check if we are on the last line of the current multi-line buffer.
  #    If so, pressing DOWN would amount to leaving the multi-line buffer.
  #
  #    We check this by adding an extra "x" to $RBUFFER, which makes
  #    sure that xrbuflines is always equal to the number of lines
  #    from $CURSOR (including the line with the cursor on it).
  #
  local buflines XRBUFFER xrbuflines
  buflines=(${(f)BUFFER})
  XRBUFFER="x"$RBUFFER
  xrbuflines=(${(f)XRBUFFER})

  if [[ $#buflines -gt 1 && $CURSOR -ne $#BUFFER && $#xrbuflines -ne 1 ]]; then
    zle down-line-or-history
    return 0
  fi

  return 1
}

_atuin-history-up-search() {
  _atuin_history_match_index+=1

  offset=$((_atuin_history_match_index-1))
  search_result=$(_atuin-history-do-search $offset "$_atuin_history_search_query")

  if [[ -z $search_result ]]; then
    # if search result is empty, there's no more history
    # so just show the previous result
    _atuin_history_match_index+=-1
    return 1
  fi

  _atuin_history_refresh_display=1
  _atuin_history_search_result="$search_result"
  return 0
}

_atuin-history-down-search() {
  # we can't go below 0
  if [[ $_atuin_history_match_index -le 0 ]]; then
    return 1
  fi

  _atuin_history_refresh_display=1
  _atuin_history_match_index+=-1

  offset=$((_atuin_history_match_index-1))
  _atuin_history_search_result=$(_atuin-history-do-search $offset "$_atuin_history_search_query")

  return 0
}

_atuin-history-do-search() {
  if [[ $1 -ge 0 ]]; then
    atuin search --filter-mode "$ATUIN_HISTORY_SEARCH_FILTER_MODE" --search-mode full-text \
      --limit 1 --offset $1 --format "{command}" \
      "$2"
  fi
}

#------END implementation----------
