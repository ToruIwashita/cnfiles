## peco-file-find-and-start-editor
_peco-file-find-and-start-editor() {
  local -aU file_path

  [[ "$BUFFER" != '' ]] && print -s "$BUFFER"

  file_path=(${(R)${(f)"$(find -type f -name "*$BUFFER*" 2>/dev/null | peco 2>/dev/null)"}%%:*})
  if [[ -z $file_path ]]; then
    zle beginning-of-line
    return 0
  fi

  BUFFER="$EDITOR $file_path"
  zle accept-line
}

zle -N peco-file-find-and-start-editor _peco-file-find-and-start-editor
