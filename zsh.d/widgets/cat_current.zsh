## cat-current
_cat-current() {
  local -a args
  args=("${(z)BUFFER}")
  zle -I
  cat ${args[$#args]}
}

zle -N cat-current _cat-current
