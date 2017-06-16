## cd-leaf-dir wedget
_cd-leaf-dir() {
  local precmd_func dest
  local -a args
  local -aU reply
  args=("${(z)BUFFER}")

  dest=$args[$#args]
  [[ $dest =~ '^~' ]] && dest=$HOME${dest#*~}
  dest=${dest//\\/}

  zle -I
  zle kill-whole-line

  (( ! $#dest )) && return

  print -s "cd $dest"
  cd $dest 2>/dev/null || cd $dest:h

  if (( ${+functions[chpwd_recent_filehandler]} && ${+functions[chpwd_recent_add]} )); then
    chpwd_recent_filehandler
    chpwd_recent_add $PWD && chpwd_recent_filehandler $reply
  fi

  (( ${+functions[precmd]} )) && precmd
  for precmd_func in $precmd_functions; do
    $precmd_func
  done
}

zle -N cd-leaf-dir _cd-leaf-dir
