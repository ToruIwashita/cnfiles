## zpeco widget
_peco-file-finder() {
  local arg resource_path
  arg=$BUFFER
  resource_path=$(find | peco)

  zle kill-whole-line
  BUFFER="$arg$resource_path"
  zle end-of-line
}
zle -N peco-file-finder _peco-file-finder
