## peco-kill-ps
peco-kill-ps() {
  local pid
  pid=$(ps -ef | peco | awk '{ print $2 }')
  if [[ -n $pid ]]; then
    kill $pid
  fi
}
