## ai-agent
ai-update() {
  print -- "--- update $AI_AGENT ---"
  $AI_AGENT update 2>&1

  echo

  print -- "--- update $AI_SUB_AGENT ---"
  $AI_SUB_AGENT update 2>&1
}
