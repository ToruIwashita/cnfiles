## double-accept-line
functions double-accept-line() {
  zle accept-line
  zle accept-line
}

zle -N double-accept-line
