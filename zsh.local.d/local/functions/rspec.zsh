## rspec
brspec() {
  integer no_binstub
  local -a file_paths
  local self_cmd help usage fail_fast_option example_option seed_option tag_option

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [spec file]
              [-c --changed-file <spec file>]
              [-e --example <string>]
              [-f --fail-fast]
              [-m --modified-file <spec file>]
              [-n --no-binstub]
              [-s --seed <seed value>]
              [-t --tag <tag name>]
              [-u --untracked-file <spec file>]
              [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -c | --changed-file)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        file_paths+=("$2")
        shift 2
        ;;
      -e | --example)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        example_option="--example '$2'"
        shift 2
        ;;
      -f | --fail-fast)
        fail_fast_option='--fail-fast'
        shift 1
        ;;
      -m | --modified-file)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        file_paths+=("$2")
        shift 2
        ;;
      -n | --no-binstub)
        (( no_binstub++ ))
        shift 1
        ;;
      -s | --seed)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        seed_option="--seed $2"
        shift 2
        ;;
      -t | --tag)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        tag_option="--tag $2"
        shift 2
        ;;
      -u | --untracked-file)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
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
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        file_paths+=("$1")
        shift 1
        ;;
    esac
  done

  if (( ! $#file_paths )); then
    print $usage
    return 1
  fi

  if (( ! no_binstub )) && [[ -f './bin/rspec' ]]; then
    cmd='./bin/rspec'
  else
    cmd='bundle exec rspec'
  fi

  print $cmd
  (ls $file_paths &>/dev/null && (eval $cmd $fail_fast_option $example_option $seed_option $tag_option $file_paths || true)) ||
    (ls $(git rev-parse --show-toplevel)/${^file_paths[*]} &>/dev/null && (eval $cmd $fail_fast_option $example_option $seed_option $tag_option $(git rev-parse --show-toplevel)/${^file_paths[*]} || true))
}
