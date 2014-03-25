## cd関連関数
functions _cdup() {
  local precmd_func

  cd ..
  type precmd > /dev/null 2>&1 && precmd 
  for precmd_func in $precmd_functions; do
    $precmd_func
  done
  zle reset-prompt
}

zle -N cdup _cdup
