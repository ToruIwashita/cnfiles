## peco_silver_search_and_start_editor
_peco-silver-search-and-start-editor() {
  local arg ag_output resource_info resource_path line_number cmd
  arg=$BUFFER
  [[ -z $arg ]] && return

  ag_output=$(ag "$arg")
  [[ -z $ag_output ]] && return

  resource_info=$(echo $ag_output | peco)
  [[ -z $resource_info ]] && return

  resource_path=${resource_info%%:*}
  line_number=${${resource_info#*:}%%:*}
  cmd="$EDITOR $resource_path +$line_number < $TTY"

  zle -I
  print -s "$cmd" && eval $cmd
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
