## peco-git-grep-and-start-editor
_peco-git-grep-and-start-editor() {
  local specified_line
  local -a peco_resulting_lines
  local -aU file_paths

  (( $#BUFFER )) && print -s "$BUFFER"

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle beginning-of-line
    return
  fi

  peco_resulting_lines=(${(f)"$(git grep --line-number "$BUFFER" | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_lines )); then
    zle beginning-of-line
    return
  fi

  if (( $#peco_resulting_lines == 1 )); then
    specified_line=+${${(M)${(M)peco_resulting_lines#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}//[:-]/}
    file_paths=${(R)${(M)peco_resulting_lines#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}
  else
    specified_line=''
    file_paths=${(R)${(M)peco_resulting_lines#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}
  fi

  BUFFER="${EDITOR:-vim} $file_paths $specified_line"
  zle accept-line
}

zle -N peco-git-grep-and-start-editor _peco-git-grep-and-start-editor
