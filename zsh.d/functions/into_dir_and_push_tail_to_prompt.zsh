## into-dir-and-push-tail-to-prompt
functions _into-dir-and-push-tail-to-prompt() {
  local args chpwd_func file_path
  args=($(print $BUFFER))
  chpwd_func=$(which chpwd)

  exec < /dev/tty
  if [[ $#args -ge 2 ]]; then
    file_path=$args[2]
  else
    file_path=$args[1]
  fi

  chpwd() { }
  cd $file_path:h
  zle reset-prompt
  eval $chpwd_func
}

zle -N into-dir-and-push-tail-to-prompt _into-dir-and-push-tail-to-prompt
