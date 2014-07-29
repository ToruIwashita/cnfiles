## into-leaf-dir wedget
_into-leaf-dir() {
  local precmd_func resource_path dest
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

  type precmd >/dev/null 2>&1 && precmd
  for precmd_func in $precmd_functions; do
    $precmd_func
  done
}

zle -N into-leaf-dir _into-leaf-dir
