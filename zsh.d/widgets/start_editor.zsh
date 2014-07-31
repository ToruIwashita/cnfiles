## start-editor
_start-editor() {
  local file_path
  local -a args
  args=("${(z)BUFFER}")
  file_path=${args[$#args]}

  zle -I
  print -s $EDITOR:t $file_path
  [[ $file_path =~ '^~' ]] && file_path=$HOME${file_path#*~}
  $EDITOR $file_path < $TTY
}

zle -N start-editor _start-editor
