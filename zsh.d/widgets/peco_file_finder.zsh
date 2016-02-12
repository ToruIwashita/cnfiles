## peco-file-finder
_peco-file-finder() {
  local -aU file_paths

  (( $#BUFFER )) && print -s "$BUFFER"

  file_paths=(${(f)"$(find -type f -name "*$BUFFER*" 2>/dev/null | peco --select-1 2>/dev/null)"})
  if (( ! $#file_paths )); then
    zle beginning-of-line
    return 0
  fi

  zle kill-whole-line
  BUFFER=$file_paths
  zle beginning-of-line
}
zle -N peco-file-finder _peco-file-finder
