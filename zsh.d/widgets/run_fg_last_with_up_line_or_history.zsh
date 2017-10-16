## run-fg-last-with-up-line-or-history
_run-fg-last-with-up-line-or-history() {
  zle up-line-or-history
  zle push-input
  BUFFER='fg'
  zle accept-line
}

zle -N run-fg-last-with-up-line-or-history _run-fg-last-with-up-line-or-history
