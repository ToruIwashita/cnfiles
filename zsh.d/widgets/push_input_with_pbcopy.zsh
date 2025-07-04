## push-input-with-pbcopy
_push-input-with-pbcopy() {
  echo -n "$BUFFER" | pbcopy
  zle push-input
}

zle -N push-input-with-pbcopy _push-input-with-pbcopy