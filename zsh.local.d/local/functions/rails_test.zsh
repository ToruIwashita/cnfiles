## rails test
init-test() {
  RAILS_ENV=test bundle exec rake db:create
  RAILS_ENV=test bundle exec rake db:migrate
}

brspec() {
  local -a args file_paths
  local self_cmd help usage tag_option

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [spec file]
              [-c --changed-file <spec file>]
              [-m --modified-file <spec file>]
              [-t --tag <tag name>]
              [-u --untracked-file <spec file>]
              [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -c | --changed-file)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        file_paths+=("$2")
        shift 2
        ;;
      -m | --modified-file)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        file_paths+=("$2")
        shift 2
        ;;
      -t | --tag)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        tag_option="--tag $2"
        shift 2
        ;;
      -u | --untracked-file)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        file_paths+=("$2")
        shift 2
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift;
        file_paths+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        file_paths+=("$1")
        shift 1
        ;;
    esac
  done

  if (( ! $file_paths )); then
    print $usage
    return 1
  fi

  if [[ -f './bin/rspec' ]]; then
    cmd='./bin/rspec'
  else
    cmd='bundle exec rspec'
  fi

  print $cmd
  eval "$cmd $tag_option $file_paths"
}
