## into-leaf-dir wedget
_into-leaf-dir() {
  local resource_path dest
  local -a args
  args=("${(z)BUFFER}")

  resource_path=$args[$#args]

  if [[ -d $resource_path || $resource_path =~ '/$' ]]; then
    dest=$resource_path
  else
    dest=$resource_path:h
  fi
  [[ $dest =~ '^~' ]] && dest=$HOME${dest#*~}

  zle -I
  zle kill-whole-line
  print -s $dest && cd $dest
}

zle -N into-leaf-dir _into-leaf-dir
