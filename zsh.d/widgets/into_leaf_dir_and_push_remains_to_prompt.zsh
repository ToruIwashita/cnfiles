## into-leaf-dir-and-push-remains-to-prompt
_into-leaf-dir-and-push-remains-to-prompt() {
  integer resource_index changed
  local precmd_func file_path dest
  local -a args
  local -aU reply
  args=("${(z)BUFFER}")

  resource_index=$#args
  file_path=$args[$resource_index]
  if [[ $file_path =~ '^~' ]]; then
    dest=$HOME${file_path#*~}
  else
    dest=$file_path
  fi
  dest=${dest//\\/}

  zle -I
  zle kill-whole-line

  cd $dest 2>/dev/null && (( changed++ ))
  if (( changed )); then
    print -s "cd $dest"
    args[$resource_index]=''
  elif [[ $file_path:h != '.' ]]; then
    dest=$dest:h
    cd $dest && print -s "cd $dest"
    args[$resource_index]=$file_path:t
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
  zle beginning-of-line
}

zle -N into-leaf-dir-and-push-remains-to-prompt _into-leaf-dir-and-push-remains-to-prompt
