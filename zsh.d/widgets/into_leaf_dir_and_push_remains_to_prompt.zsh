## into-leaf-dir-and-push-remains-to-prompt wedget
_into-leaf-dir-and-push-remains-to-prompt() {
  local chpwd_func resource_index resource_path dest
  local -a args
  args=("${(z)BUFFER}")

  resource_index=$#args
  resource_path=$args[$resource_index]

  dest=$PWD
  if [[ $resource_path =~ '/$' ]]; then
    args[$resource_index]=''
    dest=$resource_path
  elif [[ $resource_path:h != '.' ]]; then
    args[$resource_index]=$resource_path:t
    dest=$resource_path:h
  fi
  [[ $dest =~ '^~' ]] && dest=$HOME${dest#*~}

  zle -I
  zle kill-whole-line

  cd $dest
  BUFFER=$args
  zle end-of-line
}

zle -N into-leaf-dir-and-push-remains-to-prompt _into-leaf-dir-and-push-remains-to-prompt
