## peco-memolist-dir-path-pbcopy
_peco-memolist-dir-path-pbcopy() {
  local selected_dir

  selected_dir=$(find $MEMOLIST_DIR_PATH -maxdepth 1 -type d | sort | peco --select-1 2>/dev/null)

  if (( ! $#selected_dir )); then
    zle beginning-of-line
    return
  fi

  print -s "echo '$selected_dir' | pbcopy"
  print "$selected_dir" | pbcopy

  zle -I
  print "copied to clipboard: '$selected_dir'"
}

zle -N peco-memolist-dir-path-pbcopy _peco-memolist-dir-path-pbcopy
