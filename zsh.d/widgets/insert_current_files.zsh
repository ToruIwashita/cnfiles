# insert-current-files widget
_insert-current-files() {
  BUFFER="$(echo *)"
}
zle -N insert-current-files _insert-current-files
