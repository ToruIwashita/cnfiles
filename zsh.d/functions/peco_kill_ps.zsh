## peco-kill-ps
peco-kill-ps() {
  local pid answer
  local -a pids

  pids=(${(f)"$(ps -ef | peco | awk '{ print $2 }')"})

  if [[ -z $pids ]]; then
    return 0
  fi

  for pid in $pids; do
    while :; do
      print -n "Kill process $pid (y/n)? "
      read answer
      case "$answer" in
        [yY]) kill $pid
              break
              ;;
        [nN]) break
              ;;
        *)    print -n 'Please enter y or n. '
              ;;
      esac
    done
  done

  return 0
}
