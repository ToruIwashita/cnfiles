# rails test
brspec() {
  local arg cmd file_path tag_option usage

  usage=`cat <<EOF
Usage: $0 <-f 'spec file path'>
          [-t 'tag of test target']
EOF`

  while getopts :f:t: arg; do
    case ${arg} in
      f) file_path="$OPTARG" ;;
      t) tag_option="--tag $OPTARG" ;;
      :|\?) print $usage; return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ ${#file_path} -eq 0 ]]; then
    print $usage
    return 1
  fi

  if [[ -f './bin/spring'  ]]; then
    cmd='bundle exec spring rspec'
  else
    cmd='bundle exec rspec'
  fi

  print $cmd
  eval "$cmd $tag_option $file_path"
}

brspec_all() {
  local arg cmd tag_option usage

  usage=`cat <<EOF
Usage: $0 [-t 'tag of test target']
EOF`

  while getopts :t: arg; do
    case ${arg} in
      t) tag_option="--tag $OPTARG" ;;
      :|\?) print $usage; return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ $# -eq 0 ]]; then
    print $usage
    return 1
  fi

  if [[ -f './bin/spring'  ]]; then
    cmd='bundle exec spring rspec'
  else
    cmd='bundle exec rspec'
  fi

  print $cmd
  eval "$cmd $tag_option $*"
}
