## peco-kill-ps
peco-kill-ps() {
  integer force
  local -a args processes pids
  local self_cmd help usage process_list_header process pid answer

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force]
                    [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -f | --force)
        (( force++ ))
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
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

  (( ! $#processes )) && return 0

  if (( force )); then
    while :; do
      print -n 'Force kill (y/n)? '

      read answer
      case "$answer" in
        [yY]) 
          for process in $processes; do
            pid=$(echo $process | awk '{ print $2 }')
            kill $pid
          done
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
