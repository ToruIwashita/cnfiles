## peco_silver_search_and_start_editor
_peco-silver-search-and-start-editor() {
  local arg resource_info resource_path line_number cmd
  arg=$BUFFER
  [[ -z $arg ]] && return

  resource_info=$(ag "$arg" | peco)
  [[ -z $resource_info ]] && return

  resource_path=${resource_info%%:*}
  line_number=${${resource_info#*:}%%:*}
  cmd="$EDITOR $resource_path +$line_number < $TTY"

  zle -I
  print -s "$cmd" && eval $cmd
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
