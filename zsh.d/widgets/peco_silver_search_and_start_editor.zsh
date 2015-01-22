## peco-silver-search-and-start-editor
_peco-silver-search-and-start-editor() {
  local specified_line
  local -a peco_resulting_line
  local -aU file_path

  [[ "$BUFFER" != '' ]] && print -s "$BUFFER"

  peco_resulting_line=(${(f)"$(ag --silent "$BUFFER" | peco 2>/dev/null)"})
  if [[ -z $peco_resulting_line ]]; then
    zle beginning-of-line
    return 0
  fi

  if [[ $#peco_resulting_line -eq 1 ]]; then
    specified_line=+${${peco_resulting_line#*:}%%:*}
    file_path=${peco_resulting_line%%:*}
  else
    specified_line=''
    file_path=(${(R)peco_resulting_line%%:*})
  fi

  zle -I
  print -s $EDITOR:t $file_path $specified_line
  $EDITOR $file_path $specified_line < $TTY
}

zle -N peco-silver-search-and-start-editor _peco-silver-search-and-start-editor
