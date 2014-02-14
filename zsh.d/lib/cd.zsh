## cd関連関数
functions cdup() {
  echo
  cd ..
  zle reset-prompt
}

zle -N cdup
