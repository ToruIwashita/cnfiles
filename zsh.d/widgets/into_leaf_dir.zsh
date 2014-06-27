## into-leaf-dir wedget
_into-leaf-dir() {
  local resource_path dest
  local -a args
  args=("${(z)BUFFER}")

  resource_path=$args[$#args]

  if [[ $resource_path =~ '/$' ]]; then
    dest=$resource_path
  else
    dest=$resource_path:h
  fi

  zle -I
  zle kill-whole-line
  cd $dest
}

zle -N into-leaf-dir _into-leaf-dir
