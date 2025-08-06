## peco-cd-recent-dir
_peco-cd-recent-dir() {
  local -a recent_dirs
  local selected_dir

  if (( ! ${+functions[cdr]} )); then
    return 0
  fi

  recent_dirs=${(F)${${(f)"$(cdr -l)"}##<-> ##}}
  selected_dir=$(echo $recent_dirs | peco --select-1 2>/dev/null)

  if (( ! $#selected_dir )); then
    zle beginning-of-line
    return
  fi

  zle kill-whole-line
  BUFFER="cd $selected_dir"
  zle accept-line
}
zle -N peco-cd-recent-dir _peco-cd-recent-dir
