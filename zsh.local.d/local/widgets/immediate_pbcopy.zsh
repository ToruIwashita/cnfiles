## immediate-pbcopy
_immediate-pbcopy() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")

  if (( ! ${#args[$#args]} )); then
    return 0
  fi

  cmd="cat ${args[$#args]} | sed -e 's/ *$//g' pbcopy"

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-pbcopy _immediate-pbcopy
