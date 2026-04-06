## save-claude-session
_save-claude-session() {
  local session_name session_id

  zle -I
  zle push-line
  print -n '\e[?2004l'

  print -n "Session name: "
  read -r session_name < /dev/tty

  if (( ! $#session_name )); then
    print "Cancelled."
    zle get-line
    while read -k 1 -s -t 0; do :; done
    return
  fi

  print -n "Session ID: "
  read -r session_id < /dev/tty

  if (( ! $#session_id )); then
    print "Cancelled."
    zle get-line
    while read -k 1 -s -t 0; do :; done
    return
  fi

  __ai-agent-session-add "$session_name" "$session_id" "$PWD"
  print "Saved: ${session_id}@${PWD} - ${session_name}"

  zle get-line

  while read -k 1 -s -t 0; do :; done
}

zle -N save-claude-session _save-claude-session
