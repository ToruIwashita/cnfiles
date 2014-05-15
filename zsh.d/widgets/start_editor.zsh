## start-editor
_start-editor() {
  local args resource_path
  args=($(print $BUFFER))
  exec < /dev/tty
  resource_path=$args[$#args]
  $EDITOR $resource_path
}

zle -N start-editor _start-editor
