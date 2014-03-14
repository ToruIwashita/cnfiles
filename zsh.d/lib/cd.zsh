## cd関連関数
functions cdup() {
  cd ..
  zle reset-prompt
}

zle -N cdup
