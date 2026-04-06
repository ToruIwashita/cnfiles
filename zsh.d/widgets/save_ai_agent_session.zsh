## save-ai-agent-session
_save-ai-agent-session() {
  local session_name session_id

  zle -I
  zle push-line
  print -n '\e[?2004l'

  trap 'print "\nCancelled."; zle get-line; while read -k 1 -s -t 0; do :; done; trap - INT; return' INT

  print -n "Session name: "
  read -r session_name < /dev/tty

  if (( ! $#session_name )); then
    print "Cancelled."
    zle get-line
    while read -k 1 -s -t 0; do :; done
    trap - INT
    return
  fi

  print -n "Session ID: "
  read -r session_id < /dev/tty

  if (( ! $#session_id )); then
    print "Cancelled."
    zle get-line
    while read -k 1 -s -t 0; do :; done
    trap - INT
    return
  fi

  __ai-agent-session-add "$session_name" "$session_id" "$PWD"
  print "Saved: ${session_id}@~${PWD#$HOME} - ${session_name}"

  zle get-line
  while read -k 1 -s -t 0; do :; done
  trap - INT
}

zle -N save-ai-agent-session _save-ai-agent-session
