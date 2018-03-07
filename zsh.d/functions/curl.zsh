## curl関連
cl() {
  local -a args options
  local self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <URL> [-c --cookie <key=value>]
                [-j --json]
                [-p --params <key=value>]
                [--post]
                [-v --verbose]
                [-h --help]
EOF`

  # default options
  options=(-kL -I)

  while (( $# > 0 )); do
    case "$1" in
      -c | --cookie)
        if (( ! $#2  )) || [[ "$2" =~ ^-+  ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        options+=("-b '$2'")
        shift 2
        ;;
      -j | --json)
        options+=('-H "Accept: application/json" -H "Content-Type: application/json"')
        shift 1
        ;;
      -p | --params)
        if (( ! $#2  )) || [[ "$2" =~ ^-+  ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        options+=("-d '$2'")
        shift 2
        ;;
      --post)
        options=(${options:#-I})
        options+=('-X POST')
        shift 1
        ;;
      -v | --verbose)
        options=(${options:#-I})
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift;
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

  if (( ! $#args )); then
    print $usage
    return 1
  fi

  print "curl $options $args"
  echo
  eval curl $options $args
}
