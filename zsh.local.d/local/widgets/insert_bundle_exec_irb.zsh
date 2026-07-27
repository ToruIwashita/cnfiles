## insert-bundle-exec-irb
_insert-bundle-exec-irb() {
  zle push-input
  BUFFER='bundle exec irb -r $(pwd)/'
  zle end-of-line
}

zle -N insert-bundle-exec-irb _insert-bundle-exec-irb
