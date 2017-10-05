## peco-cd-dir
_peco-cd-dir() {
  local -aU dir_paths

  dir_paths=(${(f)"$(find -type d -name "*$BUFFER*" 2>/dev/null | peco --select-1 2>/dev/null)"})
  if (( ! $#dir_paths )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $dir_paths"
  zle accept-line
}
zle -N peco-cd-dir _peco-cd-dir
