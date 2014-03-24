## double-accept-line
functions double_accept_line() {
  zle accept-line
  zle accept-line
}

zle -N double_accept_line
