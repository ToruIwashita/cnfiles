## immediate-cat
_immediate-cat() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")

  if [[ -n ${args[$#args]} ]]; then
    cmd="cat ${args[$#args]}"

    zle -I
    print -s $cmd && eval $cmd
  fi
}

zle -N immediate-cat _immediate-cat
