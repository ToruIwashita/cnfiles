## mysql
my() {
  __my-connect
}

myq() {
  __my-cmd $*
}

mq() {
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

  my_cmd="cat $file_path"

  for ((i=1; i<$#args; i++)); do
    arg_num=$(expr $i + 1)
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${args[$arg_num]}/g'"
  done

  print "<<Query"
  eval $my_cmd
  print "Query\n"

  my_cmd=$my_cmd" | xargs -0 -i $(__my-cmd-self) '{}'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mqout() {
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

  my_cmd="cat $file_path"

  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $my_cmd
  print "Query\n"

  my_cmd=$my_cmd" | xargs -0 -i $(__my-cmd-self) '{}' -N | sed -e 's/	/,/g' >! $MEMOLIST_TMP_TEXT_FILE_PATH"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

myfindg() {
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
    print "Field\tType\tNull\tKey\tDefault\tExtra\n${tmp_line}"
    myq "DESC ${table_name}" -N | grep --color ${field_name}
  elif (( ${#table_name} )); then
    print "Tables\n${tmp_line}"
    __my-table-list | grep --color ${table_name}
  elif (( ${#field_name} )); then
    print "Table: 'name'\nField\tType\tNull\tKey\tDefault\tExtra\n${tmp_line}"
    for table_name in $(__my-table-list); do
      cmd_res_field_list=$(myq "DESC ${table_name}" -N | grep --color ${field_name})
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

myg() {
  local self_cmd help usage field_name table_name vertical_option query

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd [-f 'Part of field info']
           [-h --help]
           [-t 'Part of table name']
           [-v --vertical]
EOF`

  while (( $# > 0 )); do
    case "$1" in
      -f)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        field_name="$2"
        shift 2
        ;;
      -t)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument -- '$1'\n$help" 1>&2
          return 1
        fi
        table_name="$2"
        shift 2
        ;;
      -v)
        vertical_option='\G'
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
        print "$self_cmd: unknown argument -- '$1'\n$help" 1>&2
        return 1
        ;;
    esac
  done

  if (( $#field_name && $#table_name )); then
    query="SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_KEY, COLUMN_DEFAULT, EXTRA FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '$MYSQL_DATABASE' AND COLUMN_NAME LIKE '%$field_name%' AND TABLE_NAME LIKE '%$table_name%' ORDER BY TABLE_NAME${vertical_option}"
    myq "$query"
  elif (( $#field_name )); then
    query="SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE, COLUMN_KEY, COLUMN_DEFAULT, EXTRA FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = '$MYSQL_DATABASE' AND COLUMN_NAME LIKE '%$field_name%' ORDER BY TABLE_NAME${vertical_option}"
    myq "$query"
  elif (( $#table_name )); then
    query="SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = '$MYSQL_DATABASE' AND TABLE_NAME LIKE '%$table_name%'${vertical_option}"
    myq "$query"
  else
    print $usage
  fi
}

mqexp() {
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

  my_cmd="cat $file_path"

  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $my_cmd
  print "Query\n"

  my_cmd=$my_cmd" | xargs -0 -i $(__my-cmd-self) 'EXPLAIN {}\G'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mytable() {
  __check-presence-of-args $*
  (( $? )) && return 1

  print "> DESC $*;"
  mydesc $*
  echo
  print "> SHOW INDEX FROM $*;"
  myindex $*
  echo
  print "> SHOW CREATE TABLE $*\G"
  myctable $*
}

mydesc() {
  __check-presence-of-args $*
  (( $? )) && return 1

  myq "DESC ${1}"
}

myindex() {
  __check-presence-of-args $*
  (( $? )) && return 1

  myq "SHOW INDEX FROM ${1}"
}

myctable() {
  __check-presence-of-args $*
  (( $? )) && return 1

  myq "SHOW CREATE TABLE ${1}\G"
}

myshow() {
  __my-table-list
}

myfcsv() {
  __check-presence-of-args $*
  (( $? )) && return 1

  myq "DESC ${1}" -N | sed s/$'\t'.*//g | xargs -0 echo | sed -e 's/ /,/g'
}

mycnt() {
  __check-presence-of-args $*
  (( $? )) && return 1

  myq "SELECT COUNT(1) FROM ${1}"
}

watch-myps() {
  local opt g_opt usage

  usage="usage: $0 [-g]"
  while getopts :gh opt; do
    case ${opt} in
      g) g_opt='\G' ;;
      h|:|\?) print $usage; return 2 ;;
    esac
  done

  watch -n 3 "$(__my-cmd-self) 'SELECT * FROM information_schema.PROCESSLIST WHERE INFO IS NOT NULL ORDER BY TIME DESC${g_opt}'"
}

mf() {
  local -a args
  local my_cmd priority_condition group_condition limit_condition order_condition selected_field_list vertical_option where_condition table_name self_cmd help usage

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
        vertical_option='\G'
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
    my_cmd="SELECT${selected_field_list} FROM${table_name}${priority_condition}"
  else
    my_cmd="SELECT${selected_field_list} FROM${table_name}${where_condition}${group_condition}${order_condition}${limit_condition}${vertical_option}"
  fi

  print "> $my_cmd;"
  myq "$my_cmd"
}

tailf-my-query-log() {
  tail -f $LOG_DIR_PATH/mysql/query.log
}

tailf-my-slow-query-log() {
  tail -f $LOG_DIR_PATH/mysql/slow_query.log
}

tailf-my-query-upsertd-log() {
  tail -f $LOG_DIR_PATH/mysql/query.log | grep -e UPDATE -e INSERT -e DELETE
}
