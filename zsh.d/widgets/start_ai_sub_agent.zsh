## start-ai-sub-agent
_start-ai-sub-agent() {
  if (( ! $#BUFFER )); then
    BUFFER="${AI_SUB_AGENT:-codex}"
  else
    BUFFER="${AI_SUB_AGENT:-codex} --search '$BUFFER'"
  fi

  zle accept-line
}

zle -N start-ai-sub-agent _start-ai-sub-agent
