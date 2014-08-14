## peco-kill-ps
peco-kill-ps() {
  integer pid
  local answer

  pid=$(ps -ef | peco | awk '{ print $2 }')

  if [[ $pid -eq 0 ]]; then
    return 0
  fi

  while :; do
    print -n "Kill process $pid (y/n)? "
    read answer
    case "$answer" in
      [yY]) kill $pid; return 0 ;;
      [nN]) return 0 ;;
      *) print -n 'Please enter y or n. ' ;;
    esac
  done
}
