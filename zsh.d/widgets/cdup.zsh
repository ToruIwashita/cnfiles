## cdup
_cdup() {
  local precmd_func
  local -aU reply

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
}

zle -N cdup _cdup
