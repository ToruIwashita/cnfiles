# insert-current-files widget
_insert-subdirectory-file() {
  local -a subdirectory_files
  subdirectory_files=($BUFFER*(N))
  if [[ ${#subdirectory_files} -eq 1 ]]; then
    BUFFER="$(echo $subdirectory_files[1])"
    zle end-of-line
  fi
}
zle -N insert-subdirectory-file _insert-subdirectory-file
