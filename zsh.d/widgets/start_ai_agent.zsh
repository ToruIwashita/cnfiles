## start-ai-agent
_start-ai-agent() {
  BUFFER="${AI_AGENT:-claude}"

  zle accept-line
}

zle -N start-ai-agent _start-ai-agent
