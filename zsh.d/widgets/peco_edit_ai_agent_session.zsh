## peco-edit-ai-agent-session
_peco-edit-ai-agent-session() {
  local selected specified_line sessions_file
  local -a session_lines

  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle beginning-of-line
    return
  fi

  # session_idはファイル内で重複し得るため,選択した行そのものの完全一致で行番号を引く
  session_lines=("${(@f)$(<$sessions_file)}")
  specified_line=${session_lines[(ie)$selected]}

  zle kill-whole-line
  BUFFER="${EDITOR:-vim} +${specified_line} ${sessions_file}"
  zle accept-line
}

zle -N peco-edit-ai-agent-session _peco-edit-ai-agent-session
