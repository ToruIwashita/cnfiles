# rails test
brspec() {
  local arg file_path tag_option usage

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

  eval "bundle exec rspec $tag_option $file_path"
}
