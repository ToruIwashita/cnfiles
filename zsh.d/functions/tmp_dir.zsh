## clean-tmp-dir
clean-tmp-dir() {
  integer force
  local self_cmd help usage entry answer
  local -a all_entries entries

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f --force]
                     [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -f | --force)
        (( force++ ))
        shift 1
        ;;
      -h | --help)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
      -*)
        print "$self_cmd: unknown option -- '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        print "$self_cmd: requires no argument '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  # 未設定のまま展開するとrm -rfが別のパスを消しに行くため先に止める
  if (( ! $#TMP_DIR_PATH )); then
    print "$self_cmd: TMP_DIR_PATH is not set" 1>&2
    return 1
  fi

  if [[ ! -d $TMP_DIR_PATH ]]; then
    print "$self_cmd: not a directory -- '$TMP_DIR_PATH'" 1>&2
    return 1
  fi

  # AIエージェントが置く.claude等も掃除対象なのでDでドットファイルを含める
  all_entries=("$TMP_DIR_PATH"/*(ND))
  # precompactのスナップショットは圧縮後にSessionStart(compact)が読み戻すため残す
  entries=(${all_entries:#$TMP_LATEST_AI_PRECOMPACT_SNAPSHOT_FILE_PATH})

  if (( ! ${#entries} )); then
    print "$self_cmd: nothing to remove -- '$TMP_DIR_PATH'"
    return 0
  fi

  if (( ! force )); then
    print "$TMP_DIR_PATH:"

    for entry in $entries; do
      print "  ${entry:t}"
    done

    print

    while :; do
      print -n "Remove ${#entries} entries (y/n)? "

      read answer
      case "$answer" in
        [yY])
          break
          ;;
        [nN])
          return 0
          ;;
        *)
          print -n 'Please enter y or n. '
          ;;
      esac
    done
  fi

  command rm -rf -- "${entries[@]}" || return 1

  print "Removed ${#entries} entries."
}
