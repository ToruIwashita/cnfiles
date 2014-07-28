## peco_silver_search_and_start_editor
_peco-silver-search-and-start-editor() {
  local resource_info resource_path line_number

  resource_info=$(ag "$BUFFER" 2>/dev/null | peco 2>/dev/null)
  if [[ -z $resource_info ]]; then
    zle beginning-of-line
    return 0
  fi

  resource_path=${resource_info%%:*}
  line_number=${${resource_info#*:}%%:*}

  zle -I
  print -s $EDITOR:t $resource_path +$line_number
  $EDITOR $resource_path +$line_number < $TTY
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
