## peco-kill-ps
peco-kill-ps() {
  local -a args processes pids
  local self_cmd help usage process_list_header process pid answer

  self_cmd=$(echo "$0" | sed -e 's,.*/,,')
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force 'kill process without confirmation']
                    [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      --force | -f)
        force=1
        shift 1
        ;;
      --help | -h)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  process_list_header=$(ps -ef | head -1)
  processes=(${(f)"$(ps -ef | peco)"})

  if (( $force )); then
    while :; do
      print -n "Force kill (y/n)? "

      read answer
      case "$answer" in
        [yY]) 
          for process in $processes; do
            pid=$(echo $process | awk '{ print $2 }')
            kill $pid
          done
          ;;
        [nN])
          break
          ;;
        *)
          print -n 'Please enter y or n. '
          ;;
      esac
    done

    return 0
  fi

  for process in $processes; do
    pid=$(echo $process | awk '{ print $2 }')

    print "\n$process_list_header" 
    print "$process\n"

    while :; do
      print -n "Kill $pid process (y/n)? "

      read answer
      case "$answer" in
        [yY])
          kill $pid
          break
          ;;
        [nN])
          break
          ;;
        *)
          print -n 'Please enter y or n. '
          ;;
      esac
    done
  done
}


