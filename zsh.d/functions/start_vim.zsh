## double-accept-line
functions _start-vim() {
  local args file_path
  args=($(echo $BUFFER))
  exec < /dev/tty
  if [[ $#args -ge 2 ]]; then
    file_path=$args[2]
  else
    file_path=$args[1]
  fi
  vim $file_path
}

zle -N start-vim _start-vim
