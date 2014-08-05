## into-leaf-dir wedget
_into-leaf-dir() {
  local precmd_func dest
  local -a args
  local -aU reply reply_with_slash_suffix
  args=("${(z)BUFFER}")

  dest=$args[$#args]
  [[ $dest =~ '^~' ]] && dest=$HOME${dest#*~}

  zle -I
  zle kill-whole-line
  print -s $dest
  cd $dest 2>/dev/null || cd $dest:h

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
}

zle -N into-leaf-dir _into-leaf-dir
