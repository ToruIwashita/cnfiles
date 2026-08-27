## peco-resume-ai-agent-session
_peco-resume-ai-agent-session() {
  local REPLY selected ai_agent session_record session_id stored_dir session_dir models efforts model effort resume_command
  local -a reply

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle beginning-of-line
    return
  fi

  ai_agent=${${selected#\[}%%\]*}
  session_record=${selected#*| }

  if [[ $ai_agent == "$selected" || $session_record == "$selected" || $session_record != *' - '* || $session_record != *@* ]]; then
    zle -M 'peco-resume-ai-agent-session: invalid session record'
    return 1
  fi

  session_id=${session_record%% - *}
  stored_dir=${session_record##*@}
  session_dir=${stored_dir/#\~/$HOME}

  case $ai_agent in
    claude)
      models=$AI_AGENT_SESSION_CLAUDE_MODELS
      efforts=$AI_AGENT_SESSION_CLAUDE_EFFORTS
      ;;
    codex)
      models=$AI_AGENT_SESSION_CODEX_MODELS
      efforts=$AI_AGENT_SESSION_CODEX_EFFORTS
      ;;
    *)
      zle -M "peco-resume-ai-agent-session: unsupported AI agent: $ai_agent"
      return 1
      ;;
  esac

  if (( ! $#models || ! $#efforts )); then
    zle -M "peco-resume-ai-agent-session: model or effort options are empty: $ai_agent"
    return 1
  fi

  if ! __ai-agent-session-select-options 'Model' "$models" 'Effort' "$efforts"; then
    zle -R
    return
  fi
  model=$reply[1]
  effort=$reply[2]

  if ! __ai-agent-session-resume-command "$ai_agent" "$session_id" "$model" "$effort"; then
    zle -M "peco-resume-ai-agent-session: failed to build command: $ai_agent"
    return 1
  fi
  resume_command=$REPLY

  zle kill-whole-line
  BUFFER="cd ${(q)session_dir} && ${resume_command}"
  zle accept-line
}

zle -N peco-resume-ai-agent-session _peco-resume-ai-agent-session
