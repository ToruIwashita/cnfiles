## cdup
_cdup() {
  local precmd_func after_buffer
  local -a args
  local -aU reply
  args=("${(z)BUFFER}")

  if [[ $#args -ge 2 ]]; then
    after_buffer="$args[1] "
  else
    after_buffer=$BUFFER
  fi

  print -s 'cd ..' && cd ..

  if (( ${+functions[chpwd_recent_filehandler]} && ${+functions[chpwd_recent_add]} )); then
    chpwd_recent_filehandler
    chpwd_recent_add $PWD && chpwd_recent_filehandler $reply
  fi

  (( ${+functions[precmd]} )) && precmd
  for precmd_func in $precmd_functions; do
    $precmd_func
  done

  zle reset-prompt
  zle kill-whole-line
  BUFFER=$after_buffer
  zle end-of-line
}

zle -N cdup _cdup
