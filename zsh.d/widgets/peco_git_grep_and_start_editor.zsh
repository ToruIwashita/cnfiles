## peco-git-grep-and-start-editor
_peco-git-grep-and-start-editor() {
  local specified_line
  local -aU peco_resulting_line
  local -aU file_paths

  (( $#BUFFER )) && print -s "$BUFFER"

  peco_resulting_line=(${(f)"$(git grep --line-number "$BUFFER" | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_line )); then
    zle beginning-of-line
    return
  fi

  if (( $#peco_resulting_line == 1 )); then
    specified_line=+${${peco_resulting_line#*:}%%[:-]*}
    file_paths=${peco_resulting_line%%:*}
  else
    specified_line=''
    file_paths=(${(R)peco_resulting_line%%:*})
  fi

  BUFFER="${EDITOR:-vim} $file_paths $specified_line"
  zle accept-line
}

zle -N peco-git-grep-and-start-editor _peco-git-grep-and-start-editor
