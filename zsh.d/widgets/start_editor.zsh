## start-editor
_start-editor() {
  BUFFER="${EDITOR:-vim} $BUFFER"
  zle accept-line
}

zle -N start-editor _start-editor
