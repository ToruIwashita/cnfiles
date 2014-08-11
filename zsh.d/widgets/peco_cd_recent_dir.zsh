## peco-cd-recent-dir
_peco-cd-recent-dir() {
  local -a recent_dirs
  local -aU dir_path

  if (( !${+functions[cdr]} )); then
    return 0
  fi

  recent_dirs=${(F)${${(f)"$(cdr -l)"}##<-> ##}}
  dir_path=(${(f)"$(echo $recent_dirs | peco 2>/dev/null)"})

  zle kill-whole-line
  BUFFER="cd $dir_path"
  zle accept-line
}
zle -N peco-cd-recent-dir _peco-cd-recent-dir
