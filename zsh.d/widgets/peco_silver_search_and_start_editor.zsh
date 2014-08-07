## peco_silver_search_and_start_editor
_peco-silver-search-and-start-editor() {
  local _resource_info resource_info specified_line
  local -a peco_resulting_line
  local -aU file_path

  peco_resulting_line=(${(f)"$(ag "$BUFFER" 2>/dev/null | peco 2>/dev/null)"})
  if [[ -z $peco_resulting_line ]]; then
    zle beginning-of-line
    return 0
  fi

  if [[ $#peco_resulting_line -eq 1 ]]; then
    specified_line=+${${peco_resulting_line#*:}%%:*}
    resource_info=${peco_resulting_line%%:*}
    if [[ $resource_info =~ '^~' ]]; then
      file_path+=($HOME${resource_info#*~})
    else
      file_path+=($resource_info)
    fi
  else
    specified_line=''
    resource_info=${(R)peco_resulting_line%%:*}
    for _resource_info in $resource_info; do
      if [[ $_resource_info =~ '^~' ]]; then
        file_path+=($HOME${_resource_info#*~})
      else
        file_path+=($_resource_info)
      fi
    done
  fi

  zle -I
  print -s $EDITOR:t $resource_info $specified_line
  $EDITOR $file_path $specified_line < $TTY
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
