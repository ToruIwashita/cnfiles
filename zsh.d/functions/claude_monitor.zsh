## claude_monitor
watch-claude() {
  local self_cmd help usage plan
  local -a args

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <plan>
         [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift
        args+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        args+=("$1")
        shift 1
        ;;
    esac
  done

  if (( ! ${#args} )); then
    print $usage 1>&2
    return 1
  fi

  plan="${args[1]}"

  claude-monitor --plan $plan --timezone Asia/Tokyo --refresh-per-second 1.0
}
