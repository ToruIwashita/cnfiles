## cdup widgets
_cdup() {
  local precmd_func after_buffer
  local -a args
  args=($(print $BUFFER))

  if [[ $#args -ge 2 ]]; then
    args[$#args]='./'
    typeset -a after_buffer
    after_buffer=$args
  else
    after_buffer=$BUFFER
  fi

  cd ..
  type precmd > /dev/null 2>&1 && precmd 
  for precmd_func in $precmd_functions; do
    $precmd_func
  done
  zle reset-prompt
  zle kill-whole-line
  BUFFER=$after_buffer
  zle end-of-line
}

zle -N cdup _cdup
