## peco_silver_search_and_start_editor
_peco-silver-search-and-start-editor() {
  local arg ag_output resource_info resource_path line_number cmd

  resource_info=$(ag "$BUFFER" 2>/dev/null | peco 2>/dev/null)
  [[ -z $resource_info ]] && return

  resource_path=${resource_info%%:*}
  line_number=${${resource_info#*:}%%:*}
  cmd="$EDITOR $resource_path +$line_number"

  zle -I
  print -s $cmd && eval "$cmd < $TTY"
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
