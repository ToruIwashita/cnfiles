## peco-file-find-and-start-editor
_peco-file-find-and-start-editor() {
  local -aU file_paths

  file_paths=(${(R)${(f)"$(find -type f -name "*$BUFFER*" 2>/dev/null | peco --select-1 2>/dev/null)"}%%:*})
  if (( ! $#file_paths )); then
    zle beginning-of-line
    return
  fi

  BUFFER="${EDITOR:-vim} $file_paths"
  zle accept-line
}

zle -N peco-file-find-and-start-editor _peco-file-find-and-start-editor
