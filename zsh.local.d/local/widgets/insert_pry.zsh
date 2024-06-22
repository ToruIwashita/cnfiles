## insert-pry
_insert-pry() {
  zle push-input
  BUFFER='pry -r $(pwd)/'
  zle end-of-line
}

zle -N insert-pry _insert-pry
