## save-ai-agent-session
_save-ai-agent-session() {
  local selected_agent session_name session_id saved_record
  local -a reply

  zle -I
  zle push-line

  {
    if (( ! $#AI_AGENT_SESSION_AGENTS )); then
      print 'save-ai-agent-session: AI_AGENT_SESSION_AGENTS is empty' 1>&2
      return 1
    fi

    if ! __ai-agent-session-select-options 'AI agent' "$AI_AGENT_SESSION_AGENTS"; then
      print "Cancelled."
      return
    fi
    selected_agent=$reply[1]

    print -n '\e[?2004l'

    print -n "Session name: "
    if ! __ai-agent-session-read-line session_name || (( ! $#session_name )); then
      print "Cancelled."
      return
    fi

    print -n "Session ID: "
    if ! __ai-agent-session-read-line session_id || (( ! $#session_id )); then
      print "Cancelled."
      return
    fi

    saved_record=$(__ai-agent-session-format "$selected_agent" "$session_name" "$session_id" "$PWD")

    if (( ! $#saved_record )); then
      print "save-ai-agent-session: unsupported AI agent: $selected_agent" 1>&2
      return 1
    fi

    if ! __ai-agent-session-add "$selected_agent" "$session_name" "$session_id" "$PWD"; then
      print "save-ai-agent-session: failed to save session" 1>&2
      return 1
    fi
    print -r -- "Saved: $saved_record"
  } always {
    zle get-line
    while read -k 1 -s -t 0; do :; done
  }
}

zle -N save-ai-agent-session _save-ai-agent-session
