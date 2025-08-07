## peco-cd-dir
_peco-cd-dir() {
  local selected_dir

  selected_dir=$(find -type d -name "*$BUFFER*" 2>/dev/null | peco --select-1 2>/dev/null)

  if (( ! $#selected_dir )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $selected_dir"
  zle accept-line
}
zle -N peco-cd-dir _peco-cd-dir
