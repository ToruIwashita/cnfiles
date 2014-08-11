## ls-current
_ls-currnet() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")
  cmd="ls -F --color ${args[$#args]}"

  zle -I
  print -s $cmd && eval $cmd
}

zle -N ls-current _ls-currnet
