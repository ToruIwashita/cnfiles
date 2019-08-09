## immediate-tmp-text-pbcopy
_immediate-tmp-text-pbcopy() {
  local cmd file_path
  local -a args
  args=("${(z)BUFFER}")

  if (( ! ${#args[$#args]} )); then
    file_path=$MEMOLIST_TMP_TEXT_FILE_PATH
  else
    file_path=${args[$#args]}
  fi

  cmd="cat $file_path | sed -e 's/ *$//g' | pbcopy"

  zle -I
  print -s $cmd && eval $cmd
  print "$file_path copied to clipboard"
}

zle -N immediate-tmp-text-pbcopy _immediate-tmp-text-pbcopy
