## into-leaf-dir-and-push-remains-to-prompt wedget
_into-leaf-dir-and-push-remains-to-prompt() {
  integer resource_index changed
  local precmd_func resource_path dest
  local -a args
  local -aU reply
  args=("${(z)BUFFER}")

  resource_index=$#args
  resource_path=$args[$resource_index]
  if [[ $resource_path =~ '^~' ]]; then
    dest=$HOME${resource_path#*~}
  else
    dest=$resource_path
  fi

  zle -I
  zle kill-whole-line

  cd $dest 2>/dev/null && changed=1
  if (( changed )); then
    print -s $dest
    args[$resource_index]=''
  elif [[ $resource_path:h != '.' ]]; then
    dest=$dest:h
    cd $dest && print -s $dest
    args[$resource_index]=$resource_path:t
  fi

  if (( ${+functions[chpwd_recent_filehandler]} && ${+functions[chpwd_recent_add]} )); then
    chpwd_recent_filehandler
    chpwd_recent_add $PWD && chpwd_recent_filehandler $reply
  fi

  (( ${+functions[precmd]} )) && precmd
  for precmd_func in $precmd_functions; do
    $precmd_func
  done

  BUFFER=$args
  zle end-of-line
}

zle -N into-leaf-dir-and-push-remains-to-prompt _into-leaf-dir-and-push-remains-to-prompt
