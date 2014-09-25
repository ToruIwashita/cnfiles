## peco-cd-dir
_peco-cd-dir() {
  local arg
  local -aU dir_path

  [[ "$BUFFER" != '' ]] && print -s "$BUFFER"

  arg=${BUFFER:-*}
  dir_path=(${(f)"$(find -type d -name "$arg" 2>/dev/null | peco 2>/dev/null)"})
  if [[ -z $dir_path ]]; then
    zle beginning-of-line
    return 0
  fi

  zle kill-whole-line
  BUFFER="cd $dir_path"
  zle accept-line
}
zle -N peco-cd-dir _peco-cd-dir
