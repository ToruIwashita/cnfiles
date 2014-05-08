## start-editor
functions _start-editor() {
  local args file_path
  args=($(print $BUFFER))
  exec < /dev/tty
  if [[ $#args -ge 2 ]]; then
    file_path=$args[2]
  else
    file_path=$args[1]
  fi
  $EDITOR $file_path
}

zle -N start-editor _start-editor
