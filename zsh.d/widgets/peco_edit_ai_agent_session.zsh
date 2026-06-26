## peco-edit-ai-agent-session
_peco-edit-ai-agent-session() {
  local selected session_id specified_line sessions_file
  local -a session_lines

  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle beginning-of-line
    return
  fi

  session_id=${selected%% - *}
  session_lines=("${(@f)$(<$sessions_file)}")
  specified_line=${session_lines[(i)${session_id} - *]}

  zle kill-whole-line
  BUFFER="${EDITOR:-vim} +${specified_line} ${sessions_file}"
  zle accept-line
}

zle -N peco-edit-ai-agent-session _peco-edit-ai-agent-session
