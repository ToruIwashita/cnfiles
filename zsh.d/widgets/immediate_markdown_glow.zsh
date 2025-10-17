## immediate-markdown-glow
_immediate-markdown-glow() {
  local -a args

  if (( ! $#BUFFER )); then
    zle beginning-of-line
    return
  fi

  args=("${(z)BUFFER}")

  if [[ ${args[$#args]} =~ \.md$ ]]; then
    BUFFER="cat ${args[$#args]} | glow --pager"
  else
    BUFFER="cat ${args[$#args]}"
  fi

  zle accept-line
}

zle -N immediate-markdown-glow _immediate-markdown-glow
