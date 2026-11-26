## start-ai-bridge
_start-ai-bridge() {
  BUFFER="ai-bridge --session $TMUX_AI_SESSION"

  zle accept-line
}

zle -N start-ai-bridge _start-ai-bridge
