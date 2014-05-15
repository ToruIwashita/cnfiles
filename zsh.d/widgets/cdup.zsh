## cdup widgets
_cdup() {
  local file_path dir_path precmd_func
  local -a args
  args=($(print $BUFFER))

  if [[ $#args -ge 2 ]]; then
    args[2]='./'
  elif [[ $args[1] =~ '/$' ]]; then
    args[1]='./'
  fi

  cd ..
  type precmd > /dev/null 2>&1 && precmd 
  for precmd_func in $precmd_functions; do
    $precmd_func
  done
  zle reset-prompt
  zle kill-whole-line
  BUFFER=$args
  zle end-of-line
}

zle -N cdup _cdup
