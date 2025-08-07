## ai-agent-search
_ai-agent-search() {
  local buffer_content

  if (( ! $#BUFFER )); then
    zle beginning-of-line
    return
  fi

  BUFFER="${AI_SEARCH_AGENT:-gemini} -p 'WebSearch: $BUFFER' | glow"

  zle accept-line
}

zle -N ai-agent-search _ai-agent-search
