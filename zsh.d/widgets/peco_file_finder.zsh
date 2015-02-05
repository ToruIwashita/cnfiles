## peco-file-finder
_peco-file-finder() {
  local -aU file_path

  [[ "$BUFFER" != '' ]] && print -s "$BUFFER"

  file_path=(${(f)"$(find -type f -name "*$BUFFER*" 2>/dev/null | peco 2>/dev/null)"})
  if [[ -z $file_path ]]; then
    zle beginning-of-line
    return 0
  fi

  zle kill-whole-line
  BUFFER=$file_path
  zle beginning-of-line
}
zle -N peco-file-finder _peco-file-finder
