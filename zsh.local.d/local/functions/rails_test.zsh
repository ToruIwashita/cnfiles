## rails test
init-test() {
  RAILS_ENV=test bundle exec rake db:create
  RAILS_ENV=test bundle exec rake db:migrate
  RAILS_ENV=test bundle exec rake db:seed
}

brspec() {
  local opt cmd file_path tag_option usage

  usage=`cat <<EOF
usage: $0 <-f <spec file>>
              [-t 'tag of test target']
EOF`

  while getopts :f:t: opt; do
    case ${opt} in
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

  if [[ -f './bin/rspec'  ]]; then
    cmd='./bin/rspec'
  else
    cmd='bundle exec rspec'
  fi

  print $cmd 
  eval "$cmd $tag_option $file_path"
}

brspec-all() {
  local opt cmd tag_option usage

  usage=`cat <<EOF
usage: $0 [-t 'tag of test target']
EOF`

  while getopts :t: opt; do
    case ${opt} in
      t) tag_option="--tag $OPTARG" ;;
      :|\?) print $usage; return 1 ;;
    esac
  done
  shift $((OPTIND - 1))

  if [[ $# -eq 0 ]]; then
    print $usage
    return 1
  fi


  if [[ -f './bin/rspec'  ]]; then
    cmd='./bin/rspec'
  else
    cmd='bundle exec rspec'
  fi

  print $cmd 
  eval "$cmd $tag_option $*"
}
