## peco-resume-claude-session
_peco-resume-claude-session() {
  local selected session_id rest dir

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle beginning-of-line
    return
  fi

  session_id=${selected%%@*}
  rest=${selected#*@}
  dir=${rest%% - *}

  zle kill-whole-line
  BUFFER="cd ${dir} && ${AI_AGENT_WITH_OPT:-claude} --resume ${session_id}"
  zle accept-line
}

zle -N peco-resume-claude-session _peco-resume-claude-session
