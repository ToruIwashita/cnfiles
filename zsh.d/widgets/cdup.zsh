## cdup widgets
_cdup() {
  local precmd_func
  local -a args
  args=($(print $BUFFER))

  args[$#args]='./'

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
