## into-leaf-dir-and-push-remains-to-prompt wedget
_into-leaf-dir-and-push-remains-to-prompt() {
  integer resource_index changed
  local precmd_func file_path dest
  local -a args
  local -aU reply reply_with_slash_suffix
  args=("${(z)BUFFER}")

  resource_index=$#args
  file_path=$args[$resource_index]
  if [[ $file_path =~ '^~' ]]; then
    dest=$HOME${file_path#*~}
  else
    dest=$file_path
  fi

  zle -I
  zle kill-whole-line

  cd $dest 2>/dev/null && changed=1
  if (( changed )); then
    print -s $dest
    args[$resource_index]=''
  elif [[ $file_path:h != '.' ]]; then
    dest=$dest:h
    cd $dest && print -s $dest
    args[$resource_index]=$file_path:t
  fi

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

  BUFFER=$args
  zle end-of-line
}

zle -N into-leaf-dir-and-push-remains-to-prompt _into-leaf-dir-and-push-remains-to-prompt
