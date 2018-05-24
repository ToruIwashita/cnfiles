## pgsql関連関数
pg() {
  __pg-connect
}

pgq() {
  __pg-cmd $*
}

pq() {
  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <sql file>
          [-t --tmp-sql]
          [-h --help]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -t | --tmp-sql)
        (( tmp_sql++ ))
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

  if (( tmp_sql )); then
    file_path=$MEMOLIST_TMP_SQL_FILE_PATH
  else
    file_path=${args[1]}
  fi

  if (( ! $#file_path )); then
    print $usage 1>&2
    return 1
  fi

  if ! __check-arg-suffix 'sql' $file_path; then
    print $usage 1>&2
    return 1
  fi

  pg_cmd="cat $file_path"

  for ((i=1; i<$#args; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${args[$arg_num]}/g'"
  done

  print "<<Query"
  eval $pg_cmd
  print "Query\n"

  pg_cmd=$pg_cmd" | xargs -0 -i $(__pg-cmd-self) '{}'"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pqout() {
  integer arg_num
  local pg_cmd

  __pg-check-args $*
  (( $? )) && return 1

  pg_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $pg_cmd
  print "Query\n"

  pg_cmd=$pg_cmd" | xargs -0 -i $(__pg-cmd-self) '{}' -t | sed -e 's/\t/,/g' >! $MEMOLIST_TMP_TEXT_FILE_PATH"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pqexp() {
  integer arg_num
  local pg_cmd

  __pg-check-args $*
  (( $? )) && return 1

  pg_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $pg_cmd
  print "Query\n"

  pg_cmd=$pg_cmd" | xargs -0 -i $(__pg-cmd-self) 'EXPLAIN {}'"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pgdesc() {
  __pg-check-args $*
  (( $? )) && return 1

  pgq "\d ${1}"
}

pgshow() {
  pgq '\dt'
}

pgschema() {
  pgq '\dn'
}
