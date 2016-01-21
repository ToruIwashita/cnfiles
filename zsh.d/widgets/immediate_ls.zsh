## immediate-ls
_immediate-ls() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")
  cmd="ls -F --color ${args[$#args]}"

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-ls _immediate-ls
