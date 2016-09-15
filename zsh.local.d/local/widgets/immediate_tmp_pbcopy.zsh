## immediate-tmp-pbcopy
_immediate-tmp-pbcopy() {
  local cmd
  local -a args
  args=("${(z)BUFFER}")

  if (( ${#args[$#args]} )); then
    cmd="cat $MEMOLIST_TMP_FILE | pbcopy"

    zle -I
    print -s $cmd && eval $cmd
  fi
}

zle -N immediate-tmp-pbcopy _immediate-tmp-pbcopy
