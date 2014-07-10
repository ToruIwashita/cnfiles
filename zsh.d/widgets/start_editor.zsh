## start-editor
_start-editor() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")
  cmd="$EDITOR ${args[$#args]} < $TTY"

  zle -I
  print -s "$cmd" && eval $cmd
}

zle -N start-editor _start-editor
