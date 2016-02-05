## peco-cd-recent-dir
_peco-cd-recent-dir() {
  local -a recent_dirs
  local -aU dir_paths

  if (( !${+functions[cdr]} )); then
    return 0
  fi

  recent_dirs=${(F)${${(f)"$(cdr -l)"}##<-> ##}}
  dir_paths=(${(f)"$(echo $recent_dirs | peco --select-1 2>/dev/null)"})
  if [[ -z $dir_paths ]]; then
    zle beginning-of-line
    return 0
  fi

  zle kill-whole-line
  BUFFER="cd $dir_paths"
  zle accept-line
}
zle -N peco-cd-recent-dir _peco-cd-recent-dir
