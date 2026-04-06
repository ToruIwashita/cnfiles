## peco-delete-ai-agent-session
_peco-delete-ai-agent-session() {
  local selected session_id

  zle -I
  zle push-line

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle get-line
    while read -k 1 -s -t 0; do :; done
    return
  fi

  session_id=${selected%% - *}

  if read -q "?Delete '${selected}' (y/n)? "; then
    __ai-agent-session-delete "$session_id"
    print "\nDeleted."
  else
    print "\nCancelled."
  fi

  zle get-line

  while read -k 1 -s -t 0; do :; done
}

zle -N peco-delete-ai-agent-session _peco-delete-ai-agent-session
