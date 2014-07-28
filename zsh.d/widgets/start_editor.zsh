## start-editor
_start-editor() {
  local -a args
  args=("${(z)BUFFER}")

  zle -I
  print -s $EDITOR:t ${args[$#args]}
  $EDITOR ${args[$#args]} < $TTY
}

zle -N start-editor _start-editor
