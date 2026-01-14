## start-ai-sub-agent
_start-ai-sub-agent() {
  BUFFER="${AI_SUB_AGENT_WITH_OPT:-codex}"

  zle accept-line
}

zle -N start-ai-sub-agent _start-ai-sub-agent
