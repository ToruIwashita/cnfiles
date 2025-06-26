## start-ai-agent
_start-ai-agent() {
  if (( ! $#BUFFER )); then
    BUFFER="${AI_AGENT:-claude}"
  else
    BUFFER="${AI_AGENT:-claude} -p '$BUFFER'"
  fi

  zle accept-line
}

zle -N start-ai-agent _start-ai-agent
