## immediate-tmp-markdown-pbcopy
_immediate-tmp-markdown-pbcopy() {
  local cmd file_path
  local -a args
  args=("${(z)BUFFER}")

  if (( ! ${#args[$#args]} )); then
    file_path=$MEMOLIST_TMP_MARKDOWN_FILE_PATH
  else
    file_path=${args[$#args]}
  fi

  cmd="cat $file_path | sed -e 's/ *$//g' | pbcopy"

  zle -I
  print -s $cmd && eval $cmd
  print "copied to clipboard: '$file_path'"
}

zle -N immediate-tmp-markdown-pbcopy _immediate-tmp-markdown-pbcopy
