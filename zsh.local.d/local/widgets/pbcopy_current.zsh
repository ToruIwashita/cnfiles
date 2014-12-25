## pbcopy-current
_pbcopy-current() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")

  if [[ -n ${args[$#args]} ]]; then
    cmd="cat ${args[$#args]} | pbcopy"

    zle -I
    print -s $cmd && eval $cmd
  fi
}

zle -N pbcopy-current _pbcopy-current
