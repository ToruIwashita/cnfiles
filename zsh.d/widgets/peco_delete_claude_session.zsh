## peco-delete-claude-session
_peco-delete-claude-session() {
  local selected session_id rest session_name

  zle -I
  zle push-line

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle get-line
    while read -k 1 -s -t 0; do :; done
    return
  fi

  session_id=${selected%%@*}
  rest=${selected#*@}
  session_name=${rest##* - }

  if read -q "?Delete '${session_name}' (y/n)? "; then
    __ai-agent-session-delete "$session_id"
    print "\nDeleted."
  else
    print "\nCancelled."
  fi

  zle get-line

  while read -k 1 -s -t 0; do :; done
}

zle -N peco-delete-claude-session _peco-delete-claude-session
