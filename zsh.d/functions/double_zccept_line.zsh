## double-accept-line
functions _double-accept-line() {
  zle accept-line
  zle accept-line
}

zle -N double-accept-line _double-accept-line
