## insert-irb
_insert-irb() {
  zle push-input
  BUFFER='irb -r $(pwd)/'
  zle end-of-line
}

zle -N insert-irb _insert-irb
