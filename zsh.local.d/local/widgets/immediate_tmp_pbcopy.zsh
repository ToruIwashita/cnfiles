## immediate-tmp-pbcopy
_immediate-tmp-pbcopy() {
  local cmd

  cmd="cat $MEMOLIST_TMP_FILE_PATH | pbcopy"

  zle -I
  print -s $cmd && eval $cmd
}

zle -N immediate-tmp-pbcopy _immediate-tmp-pbcopy
