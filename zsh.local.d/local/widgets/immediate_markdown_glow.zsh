## immediate-markdown-glow
_immediate-markdown-glow() {
  local -a args

  args=("${(z)BUFFER}")

  if (( ${#args[$#args]} )); then
    if [[ ${args[$#args]} =~ \.md$ ]]; then
      BUFFER="cat ${args[$#args]} | glow --pager"
    else
      BUFFER="cat ${args[$#args]}"
    fi
    zle accept-line
  fi
}

zle -N immediate-markdown-glow _immediate-markdown-glow
