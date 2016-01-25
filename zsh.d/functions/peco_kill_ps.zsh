## peco-kill-ps
peco-kill-ps() {
  local process_list_header process pid answer 
  local -a processes pids

  process_list_header=$(ps -ef | head -1)
  processes=(${(f)"$(ps -ef | peco)"})

  for process in $processes; do
    pid=$(echo $process | awk '{ print $2 }')

    print "\n$process_list_header" 
    print "$process\n"

    while :; do
      print -n "Kill $pid process (y/n)? "

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
