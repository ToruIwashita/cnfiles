## insert-bundle-exec-pry
_insert-bundle-exec-pry() {
  zle push-input
  BUFFER='bundle exec pry -r $(pwd)'
}

zle -N insert-bundle-exec-pry _insert-bundle-exec-pry
