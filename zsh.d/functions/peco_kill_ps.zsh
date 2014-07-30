## peco-kill-ps
peco-kill-ps() {
  integer pid
  pid=$(ps -ef | peco | awk '{ print $2 }')
  if [[ -n $pid ]]; then
    kill $pid
  fi
}
