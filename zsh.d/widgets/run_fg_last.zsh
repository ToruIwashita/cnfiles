## run-fg-last
_run-fg-last() {
  zle push-input
  BUFFER='fg'
  zle accept-line
}

zle -N run-fg-last _run-fg-last
