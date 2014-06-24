## cat-current
_cat-current() {
  local -a args
  args=("${(z)BUFFER}")
  if [[ -n ${args[$#args]} ]]; then
    zle -I
    cat ${args[$#args]}
  fi
}

zle -N cat-current _cat-current
