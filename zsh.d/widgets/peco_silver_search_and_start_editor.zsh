## peco_silver_search_and_start_editor
_peco-silver-search-and-start-editor() {
  integer line_number
  local resource_info file_path

  resource_info=$(ag "$BUFFER" 2>/dev/null | peco 2>/dev/null)
  if [[ -z $resource_info ]]; then
    zle beginning-of-line
    return 0
  fi

  file_path=${resource_info%%:*}
  line_number=${${resource_info#*:}%%:*}

  zle -I
  print -s $EDITOR:t $file_path +$line_number
  $EDITOR $file_path +$line_number < $TTY
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
