## ai-agent-session

__ai-agent-session-prefix() {
  case $1 in
    claude)
      print -nr -- '[claude] | '
      ;;
    codex)
      print -nr -- '[codex]  | '
      ;;
    *)
      return 1
      ;;
  esac
}

__ai-agent-session-format() {
  local ai_agent session_name session_id session_path session_dir session_prefix

  ai_agent=$1
  session_name=$2
  session_id=$3
  session_path=$4

  if [[ $session_path == "$HOME" ]]; then
    session_dir='~'
  elif [[ $session_path == "$HOME"/* ]]; then
    session_dir="~${session_path#"$HOME"}"
  else
    session_dir=$session_path
  fi

  session_prefix=$(__ai-agent-session-prefix "$ai_agent") || return 1

  print -r -- "${session_prefix}${session_id} - ${session_name}@${session_dir}"
}

__ai-agent-session-add() {
  local ai_agent session_name session_id session_path session_prefix session_record record_key sessions_file sessions_file_tmp

  ai_agent=$1
  session_name=$2
  session_id=$3
  session_path=$4
  session_prefix=$(__ai-agent-session-prefix "$ai_agent") || return 1
  session_record=$(__ai-agent-session-format "$ai_agent" "$session_name" "$session_id" "$session_path") || return 1
  record_key="${session_prefix}${session_id} - "
  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  if [[ ! -f $sessions_file ]]; then
    return 1
  fi

  sessions_file_tmp=$(command mktemp "${sessions_file}.tmp.XXXXXX") || return 1

  {
    awk -v key="$record_key" 'index($0, key) != 1 { print }' "$sessions_file" >| "$sessions_file_tmp" || return 1
    print -r -- "$session_record" >> "$sessions_file_tmp" || return 1
    command mv "$sessions_file_tmp" "$sessions_file"
  } always {
    [[ ! -e $sessions_file_tmp ]] || command rm -f "$sessions_file_tmp"
  }
}

__ai-agent-session-update-id() {
  local session_name session_id sessions_file sessions_file_tmp

  session_name=$1
  session_id=$2
  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  if [[ ! -f $sessions_file ]]; then
    return 1
  fi

  if (( $(grep -Fc -- " - ${session_name}@" "$sessions_file") != 1 )); then
    return 1
  fi

  sessions_file_tmp=$(command mktemp "${sessions_file}.tmp.XXXXXX") || return 1

  {
    awk -v name=" - ${session_name}@" -v id="$session_id" '
      index($0, name) { sub(/[|] [^ ]+ - /, "| " id " - ") }
      { print }
    ' "$sessions_file" >| "$sessions_file_tmp" || return 1
    command mv "$sessions_file_tmp" "$sessions_file"
  } always {
    [[ ! -e $sessions_file_tmp ]] || command rm -f "$sessions_file_tmp"
  }
}

__ai-agent-session-list() {
  if [[ ! -f $AI_AGENT_SESSIONS_FILE_PATH ]]; then
    return 1
  fi

  command cat "$AI_AGENT_SESSIONS_FILE_PATH"
}

__ai-agent-session-delete() {
  integer grep_status
  local session_record sessions_file sessions_file_tmp

  session_record=$1
  sessions_file=$AI_AGENT_SESSIONS_FILE_PATH

  if [[ ! -f $sessions_file ]]; then
    return 1
  fi

  if ! grep -Fxq -- "$session_record" "$sessions_file"; then
    return 1
  fi

  sessions_file_tmp=$(command mktemp "${sessions_file}.tmp.XXXXXX") || return 1

  {
    grep -Fxv -- "$session_record" "$sessions_file" >| "$sessions_file_tmp"
    grep_status=$?

    if (( grep_status > 1 )); then
      return 1
    fi

    command mv "$sessions_file_tmp" "$sessions_file"
  } always {
    [[ ! -e $sessions_file_tmp ]] || command rm -f "$sessions_file_tmp"
  }
}

__ai-agent-session-resume-command() {
  local ai_agent session_id model effort agent_command model_option effort_option effort_config

  ai_agent=$1
  session_id=$2
  model=$3
  effort=$4

  if [[ $model == default ]]; then
    model_option=
  else
    model_option=" --model ${(q)model}"
  fi

  case $ai_agent in
    claude)
      agent_command=$AI_AGENT_SESSION_CLAUDE_COMMAND

      if [[ $effort == default ]]; then
        effort_option=
      else
        effort_option=" --effort ${(q)effort}"
      fi

      if (( ! $#agent_command )); then
        return 1
      fi

      REPLY="${agent_command} --resume ${(q)session_id}${model_option}${effort_option}"
      ;;
    codex)
      agent_command=$AI_AGENT_SESSION_CODEX_COMMAND

      if [[ $effort == default ]]; then
        effort_option=
      else
        effort_config="model_reasoning_effort=\"${effort}\""
        effort_option=" --config ${(q)effort_config}"
      fi

      if (( ! $#agent_command )); then
        return 1
      fi

      REPLY="${agent_command} resume ${(q)session_id}${model_option}${effort_option}"
      ;;
    *)
      return 1
      ;;
  esac
}

__ai-agent-session-read-line() {
  local terminal_state

  terminal_state=$(command stty -g < /dev/tty) || return 1

  {
    command stty icanon echo intr undef eof '^C' < /dev/tty || return 1
    if ! IFS= read -r "$1" < /dev/tty; then
      print '^C'
      return 130
    fi
  } always {
    command stty "$terminal_state" < /dev/tty
  }
}

__ai-agent-session-select-next() {
  if (( __ai_agent_session_select_index == ${#__ai_agent_session_select_options} )); then
    __ai_agent_session_select_index=1
  else
    (( __ai_agent_session_select_index++ ))
  fi

  BUFFER="${__ai_agent_session_select_prefix}${__ai_agent_session_select_options[$__ai_agent_session_select_index]}"
  CURSOR=$#BUFFER
}

__ai-agent-session-select-previous() {
  if (( __ai_agent_session_select_index == 1 )); then
    __ai_agent_session_select_index=${#__ai_agent_session_select_options}
  else
    (( __ai_agent_session_select_index-- ))
  fi

  BUFFER="${__ai_agent_session_select_prefix}${__ai_agent_session_select_options[$__ai_agent_session_select_index]}"
  CURSOR=$#BUFFER
}

__ai-agent-session-display-selection() {
  integer stage stage_index
  local options_csv prompt_label selection_prompt selected_line

  stage=$__ai_agent_session_select_stage
  prompt_label=$__ai_agent_session_select_labels[$stage]
  options_csv=$__ai_agent_session_select_option_lists[$stage]
  __ai_agent_session_select_options=("${(@s:,:)options_csv}")
  __ai_agent_session_select_index=1
  selection_prompt="${prompt_label} [${(j: / :)__ai_agent_session_select_options}] (C-n/C-p): "
  __ai_agent_session_select_prompts[$stage]=$selection_prompt
  __ai_agent_session_select_prefix=$'\n'

  for (( stage_index = 1; stage_index < stage; stage_index++ )); do
    selected_line="${__ai_agent_session_select_prompts[$stage_index]}${__ai_agent_session_selected_options[$stage_index]}"
    __ai_agent_session_select_prefix+="${selected_line}"$'\n'
  done

  __ai_agent_session_select_prefix+=$selection_prompt
  BUFFER="${__ai_agent_session_select_prefix}${__ai_agent_session_select_options[$__ai_agent_session_select_index]}"
  CURSOR=$#BUFFER
}

__ai-agent-session-accept-selection() {
  local selected_option

  selected_option=$__ai_agent_session_select_options[$__ai_agent_session_select_index]
  __ai_agent_session_selected_options[$__ai_agent_session_select_stage]=$selected_option

  if (( __ai_agent_session_select_stage < ${#__ai_agent_session_select_labels} )); then
    (( __ai_agent_session_select_stage++ ))
    __ai-agent-session-display-selection
    return
  fi

  zle .accept-line
}

__ai-agent-session-cancel-selection() {
  __ai_agent_session_select_cancelled=1
  zle .accept-line
}

__ai-agent-session-select-options() {
  integer initial_cursor recursive_status stage_index __ai_agent_session_select_cancelled __ai_agent_session_select_index __ai_agent_session_select_stage
  local prompt_label options_csv initial_buffer initial_keymap selected_line __ai_agent_session_select_prefix
  local -a __ai_agent_session_select_labels __ai_agent_session_select_option_lists __ai_agent_session_select_options __ai_agent_session_select_prompts __ai_agent_session_selected_options

  if (( $# == 0 || $# % 2 != 0 )); then
    return 1
  fi

  while (( $# )); do
    prompt_label=$1
    options_csv=$2
    shift 2

    if (( ! $#prompt_label || ! $#options_csv )); then
      return 1
    fi

    __ai_agent_session_select_labels+=("$prompt_label")
    __ai_agent_session_select_option_lists+=("$options_csv")
  done

  initial_buffer=$BUFFER
  initial_cursor=$CURSOR
  initial_keymap=$KEYMAP
  recursive_status=1
  __ai_agent_session_select_stage=1
  __ai-agent-session-display-selection

  {
    zle -K ai-agent-session-select
    zle recursive-edit
    recursive_status=$?
  } always {
    zle -K $initial_keymap
    BUFFER=$initial_buffer
    CURSOR=$initial_cursor
  }

  zle -I

  if (( recursive_status || __ai_agent_session_select_cancelled )); then
    return 1
  fi

  for (( stage_index = 1; stage_index <= ${#__ai_agent_session_select_labels}; stage_index++ )); do
    selected_line="${__ai_agent_session_select_prompts[$stage_index]}${__ai_agent_session_selected_options[$stage_index]}"
    print -r -- "$selected_line"
  done

  reply=("${__ai_agent_session_selected_options[@]}")
}

if [[ -o interactive ]]; then
  zle -N __ai-agent-session-select-next
  zle -N __ai-agent-session-select-previous
  zle -N __ai-agent-session-accept-selection
  zle -N __ai-agent-session-cancel-selection
  bindkey -N ai-agent-session-select emacs
  bindkey -M ai-agent-session-select '^N' __ai-agent-session-select-next
  bindkey -M ai-agent-session-select '^P' __ai-agent-session-select-previous
  bindkey -M ai-agent-session-select '^J' __ai-agent-session-accept-selection
  bindkey -M ai-agent-session-select '^M' __ai-agent-session-accept-selection
  bindkey -M ai-agent-session-select '^C' __ai-agent-session-cancel-selection
fi
