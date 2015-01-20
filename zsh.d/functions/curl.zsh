## curl関連
cl() {
  local usage option arg

  usage=`cat <<EOF
Usage: $0 <URL>
          [-v 'verbose']
EOF`

  while getopts :v arg; do
    case ${arg} in
      v) option='-v' ;;
      :|\?) print $usage; return 1 ;;
    esac
  done
  shift $((OPTIND-1))

  if (( ! $# )); then
    print $usage
    return 1
  fi

  if (( ! ${#option} )); then
    curl -kL -I $*
  else
    curl -kL $option $* >/dev/null
  fi
}
