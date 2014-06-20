# insert-current-files widget
_insert-nest-file() {
  local -a nest_files
  nest_files=($BUFFER*)
  if [[ ${#nest_files} -eq 1 ]]; then
    BUFFER="$(echo $nest_files[1])"
    zle end-of-line
  fi
}
zle -N insert-nest-file _insert-nest-file
