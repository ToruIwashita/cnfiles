## zpeco widget
_peco-file-finder() {
  local arg file_path
  arg=$BUFFER
  file_path=$(find | peco)

  zle kill-whole-line
  BUFFER="$arg$file_path"
  zle end-of-line
}
zle -N peco-file-finder _peco-file-finder
