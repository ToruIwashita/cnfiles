## cdup widget
_cdup() {
  local precmd_func after_buffer
  local -a args
  local -aU reply reply_with_slash_suffix
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
    chpwd_recent_filehandler
    reply_with_slash_suffix=(${^reply%/}/)
    chpwd_recent_filehandler $reply_with_slash_suffix
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
