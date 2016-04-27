## start-editor
_start-editor() {
  local file_path
  local -a args
  args=("${(z)BUFFER}")
  file_path=${args[$#args]}

  BUFFER="${EDITOR:-vim} $file_path"
  zle accept-line
}

zle -N start-editor _start-editor
