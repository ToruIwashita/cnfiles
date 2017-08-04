## edge-start-editor
_edge-start-editor() {
  local file_path
  local -a args
  args=("${(z)BUFFER}")
  file_path=${args[$#args]}

  BUFFER="${EDITOR:-vim} $file_path"
  zle accept-line
}

zle -N edge-start-editor _edge-start-editor
