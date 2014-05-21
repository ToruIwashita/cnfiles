## double-accept-line wedget
_double-send-break() {
  zle send-break
  zle send-break
}

zle -N double-send-break _double-send-break
