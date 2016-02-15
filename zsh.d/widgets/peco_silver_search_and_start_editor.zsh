## peco-silver-search-and-start-editor
_peco-silver-search-and-start-editor() {
  local context parttern specified_line
  local -a args peco_resulting_line
  local -aU file_paths

  (( $#BUFFER )) && print -s "$BUFFER"

  args=("${(z)BUFFER}")
  if (( $#args >= 2 )) && [[ ${args[-1]} =~ '^[0-9]*$' ]]; then
    context="-C ${args[-1]}"
    pattern=${args:0:-1}
  else
    context=''
    pattern=$args
  fi

  peco_resulting_line=(${(f)"$(ag --silent $context "$pattern" | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_line )); then
    zle beginning-of-line
    return 0
  fi

  if (( $#peco_resulting_line == 1 )); then
    specified_line=+${${peco_resulting_line#*:}%%[:-]*}
    file_paths=${peco_resulting_line%%:*}
  else
    specified_line=''
    file_paths=(${(R)peco_resulting_line%%:*})
  fi

  BUFFER="$EDITOR $file_paths $specified_line"
  zle accept-line
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
