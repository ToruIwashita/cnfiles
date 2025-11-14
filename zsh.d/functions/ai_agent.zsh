## ai-agent
ai-update() {
  print -- "--- update $AI_AGENT ---"
  $AI_AGENT update 2>&1

  echo

  print -- "--- update $AI_SUB_AGENT ---"
  npm install -g @openai/$AI_SUB_AGENT 2>&1 | sed '/./,$!d'
}
