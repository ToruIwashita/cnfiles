## ai-agent-session

__ai-agent-session-add() {
  local session_name session_id session_dir sessions_file

  session_name=$1
  session_id=$2
  session_dir=$3
  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  if [[ ! -f $sessions_file ]]; then
    return 1
  fi

  if grep -Fq "${session_id}@" $sessions_file; then
    grep -Fv "${session_id}@" $sessions_file > ${sessions_file}.tmp
    mv ${sessions_file}.tmp $sessions_file
  fi

  print "${session_id}@${session_dir} - ${session_name}" >> $sessions_file
}

__ai-agent-session-list() {
  local sessions_file

  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  if [[ ! -f $sessions_file ]]; then
    return 1
  fi

  cat $sessions_file
}

__ai-agent-session-delete() {
  local session_id sessions_file

  session_id=$1
  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  if [[ ! -f $sessions_file ]]; then
    return 1
  fi

  grep -Fv "${session_id}@" $sessions_file > ${sessions_file}.tmp
  mv ${sessions_file}.tmp $sessions_file
}
