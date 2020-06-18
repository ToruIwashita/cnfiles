## pgsql
pg() {
  __pg-connect
}

pgq() {
  __pg-cmd $*
}

pq() {
  integer arg_num tmp_sql
  local -a args
  local self_cmd help usage my_cmd file_path

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
  integer arg_num tmp_sql
  local -a args
  local self_cmd help usage pg_cmd file_path

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

  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $pg_cmd
  print "Query\n"

  pg_cmd=$pg_cmd" | xargs -0 -i $(__pg-cmd-self) '{}' -A -F, --tuples-only  >! $MEMOLIST_TMP_TEXT_FILE_PATH"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pgfindg() {
  local cmd_res_field_list cmd_res_field_name table_name field_name tmp_line usage opt

  usage="usage: $0 [-f 'Part of field info'] [-t 'Part of table name']"
  while getopts :f:t: opt; do
    case ${opt} in
      f) field_name=${OPTARG} ;;
      t) table_name=${OPTARG} ;;
      :|\?) print $usage; return 1 ;;
    esac
  done

  tmp_line="-------------------------------------------------------"
  if (( ${#table_name} && ${#field_name} )); then
    print "Column  |  Type  |  Modifiers\n${tmp_line}"
    pgq "\d ${table_name}" --tuples-only | grep --color ${field_name}
  elif (( ${#table_name} )); then
    print "Tables\n${tmp_line}"
    __pg-table-list | grep --color ${table_name}
  elif (( ${#field_name} )); then
    print "Table: 'name'\nColumn  |  Type  |  Modifiers\n${tmp_line}"
    for table_name in $(__pg-table-list); do
      cmd_res_field_list=$(pgq "\d ${table_name}" --tuples-only | grep --color ${field_name})
      if (( ${#cmd_res_field_list} )); then
        print "Table: ${table_name}"
        for cmd_res_field_name in ${(f)cmd_res_field_list}; do
          print $cmd_res_field_name | grep --color "${field_name}"
        done
        print
      fi
    done
  else
    print $usage
  fi
}

pqexp() {
  integer arg_num tmp_sql
  local -a args
  local self_cmd help usage pg_cmd file_path

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

pgfcsv() {
  __check-presence-of-args $*
  (( $? )) && return 1

  pgq "\d ${1}" --tuples-only | sed s/$'|'.*//g | xargs -0 echo | sed -e 's/ /,/g'
}

pgcnt() {
  __check-presence-of-args $*
  (( $? )) && return 1

  pgq "SELECT COUNT(1) FROM ${1}"
}

watch-pgps() {
  integer g_opt
  local opt usage query

  usage="usage: $0 [-g]"
  while getopts :gh opt; do
    case ${opt} in
      g) (( g_opt++ )) ;;
      h|:|\?) print $usage; return 2 ;;
    esac
  done

  query="SELECT procpid, start, now() - start AS lap, current_query FROM (SELECT backendid, pg_stat_get_backend_pid(S.backendid) AS procpid, pg_stat_get_backend_activity_start(S.backendid) AS start, pg_stat_get_backend_activity(S.backendid) AS current_query FROM (SELECT pg_stat_get_backend_idset() AS backendid) AS S) AS S WHERE current_query <> '' ORDER BY lap DESC"

  if (( g_opt )); then
    watch -n 3 "$(__pg-cmd-self) \"${query}\" -x"
  else
    watch -n 3 "$(__pg-cmd-self) \"${query}\""
  fi
}

pf() {
  integer vertical_option
  local -a args
  local pg_cmd priority_condition group_condition limit_condition order_condition selected_field_list where_condition table_name self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <table name>
          [-a --id-asc <order by id asc>]
          [-c --primary-condition <highest priority condition>]
          [-d --id-desc <order by id desc>]
          [-g --group-by <group condition>]
          [-h --help]
          [-l --limit <limit value>]
          [-o --order-by <order condition>]
          [-s --select <select fields>]
          [-v --vertical]
          [-w --where <where condition>]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -a | --id-asc)
        order_condition=" ORDER BY id ASC"
        shift 1
        ;;
      -c | --primary-condition)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        priority_condition=" $2"
        shift 2
        ;;
      -d | --id-desc)
        order_condition=" ORDER BY id DESC"
        shift 1
        ;;
      -g | --group-by)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        group_condition=" GROUP BY $2"
        shift 2
        ;;
      -l | --limit)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        limit_condition=" LIMIT $2"
        shift 2
        ;;
      -o | --order-by)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        order_condition=" ORDER BY $2"
        shift 2
        ;;
      -s | --select)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        selected_field_list=" $2"
        shift 2
        ;;
      -v | --vertical)
        (( vertical_option++ ))
        shift 1
        ;;
      -w | --where)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        where_condition=" WHERE $2"
        shift 2
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
  table_name=" ${args[1]}"

  (( ! $#selected_field_list )) && selected_field_list=' *'

  if (( $#priority_condition )); then
    pg_cmd="SELECT${selected_field_list} FROM${table_name}${priority_condition}"
  else
    pg_cmd="SELECT${selected_field_list} FROM${table_name}${where_condition}${group_condition}${order_condition}${limit_condition}"
  fi

  print "> $pg_cmd;"

  if (( vertical_option )); then
    pgq "$pg_cmd" -x
  else
    pgq "$pg_cmd"
  fi
}
