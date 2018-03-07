## curl関連
cl() {
  local -a args options
  local self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <URL> [-j --json]
                [-v --verbose]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -j | --json)
        options+=('-H "Content-Type: application/json"')
        shift 1
        ;;
      -v | --verbose)
        options+=('-I')
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

  curl -kL $options $args
}
