## ls-current widget
_ls-currnet() {
  local -a args
  args=("${(z)BUFFER}")
  if [[ -n ${args[$#args]} ]]; then
    zle -I
    ls ${args[$#args]}
  fi
}

zle -N ls-current _ls-currnet
