## curl関連
cl() {
  local usage verbose_mode opt

  usage="usage: $0 [-v 'verbose'] <URL>"

  while getopts :v opt; do
    case ${opt} in
      v) verbose_mode=1 ;;
      :|\?) print $usage; return 1 ;;
    esac
  done
  shift $((OPTIND-1))

  if (( ! $# )); then
    print $usage
    return 1
  fi

  if (( $verbose_mode )); then
    curl -kL -I $*
  else
    curl -kL $option $* >/dev/null
  fi
}
