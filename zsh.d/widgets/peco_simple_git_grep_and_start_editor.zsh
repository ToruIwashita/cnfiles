## peco-simple-git-grep-and-start-editor
_peco-simple-git-grep-and-start-editor() {
  local specified_line
  local -a peco_resulting_line
  local -aU file_paths

  if ( ! $(git rev-parse 2>/dev/null) ); then
    zle beginning-of-line
    return
  fi

  peco_resulting_line=(${(f)"$(git grep --line-number "$BUFFER" | peco --select-1 2>/dev/null)"})

  if (( ! $#peco_resulting_line )); then
    zle beginning-of-line
    return
  fi

  if (( $#peco_resulting_line == 1 )); then
    specified_line=+${${(M)${(M)peco_resulting_line#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}//[:-]/}
    file_paths=${(R)${(M)peco_resulting_line#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}
  else
    specified_line=''
    file_paths=${(R)${(M)peco_resulting_line#*[:-][0-9]*[:-]}%[:-][0-9]*[:-]}
  fi

  BUFFER="${EDITOR:-vim} $file_paths $specified_line"
  zle accept-line
}

zle -N peco-simple-git-grep-and-start-editor _peco-simple-git-grep-and-start-editor
