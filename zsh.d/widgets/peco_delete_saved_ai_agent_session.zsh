## peco-delete-saved-ai-agent-session
_peco-delete-saved-ai-agent-session() {
  local selected

  zle -I
  zle push-line

  {
    selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

    if (( ! $#selected )); then
      return
    fi

    if read -q "?Delete '${selected}' (y/n)? "; then
      if __ai-agent-session-delete "$selected"; then
        print "\nDeleted."
      else
        print "\npeco-delete-saved-ai-agent-session: failed to delete session" 1>&2
      fi
    else
      print "\nCancelled."
    fi
  } always {
    zle get-line
    while read -k 1 -s -t 0; do :; done
  }
}

zle -N peco-delete-saved-ai-agent-session _peco-delete-saved-ai-agent-session
