## start-ai-bridge
_start-ai-bridge() {
  BUFFER=ai-bridge

  zle accept-line
}

zle -N start-ai-bridge _start-ai-bridge
