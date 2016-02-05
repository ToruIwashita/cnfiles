## immediate-pbcopy
_immediate-pbcopy() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")

  if [[ -n ${args[$#args]} ]]; then
    cmd="cat ${args[$#args]} | pbcopy"

    zle -I
    print -s $cmd && eval $cmd
  fi
}

zle -N immediate-pbcopy _immediate-pbcopy
