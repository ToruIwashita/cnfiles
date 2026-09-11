## peco-ai-agent-session-name-pbcopy
_peco-ai-agent-session-name-pbcopy() {
  local cmd selected session_name

  selected=$(__ai-agent-session-list | peco --select-1 2>/dev/null)

  if (( ! $#selected )); then
    zle beginning-of-line
    return
  fi

  # session_name自体に@が含まれ得るため,ディレクトリ側は最後の@で切り落とす
  session_name=${${selected#* - }%@*}

  cmd="echo -n ${(q)session_name} | pbcopy"

  zle -I
  print -s ${(q)cmd} && eval $cmd
  print "copied to clipboard: '$session_name'"
}

zle -N peco-ai-agent-session-name-pbcopy _peco-ai-agent-session-name-pbcopy
