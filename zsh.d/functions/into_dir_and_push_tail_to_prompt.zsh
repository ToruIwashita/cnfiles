## into-dir-and-push-tail-to-prompt wedget
_into-dir-and-push-tail-to-prompt() {
  local chpwd_func arg_index file_path dir_path
  local -a args
  args=($(print $BUFFER))
  chpwd_func=$(typeset -f chpwd)

  if [[ $#args -ge 2 ]]; then
    arg_index=2
  else
    arg_index=1
  fi
  file_path=$args[$arg_index]

  dir_path=$PWD
  if [[ $file_path =~ '/$' ]]; then
    args[$arg_index]='./'
    dir_path=$file_path
  elif [[ $file_path:h != '.' ]]; then
    args[$arg_index]=$file_path:t
    dir_path=$file_path:h
  fi

  chpwd() { }
  cd $dir_path
  eval $chpwd_func

  zle reset-prompt
  zle kill-whole-line
  BUFFER=$args
  zle end-of-line
}

zle -N into-dir-and-push-tail-to-prompt _into-dir-and-push-tail-to-prompt
