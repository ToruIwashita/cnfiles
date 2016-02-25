## MYSQL
__my-check-presence-of-args() {
  if (( ! $# )); then
    print 'lack of arguments.' 2>&1
    return 1
  fi

  return 0
}
__my-check-args() {
  __my-check-presence-of-args $*
  (( $? )) && return 1

  if [[ $1:e != 'sql' ]]; then
    print 'invalid extension.' 2>&1
    return 1
  fi

  return 0
}

mq() {
  integer arg_num
  local my_cmd

  __my-check-args $*
  (( $? )) && return 1

  my_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $my_cmd
  print "Query\n"

  my_cmd=$my_cmd" | xargs -0 -i ${MYSQL_CMD} '{}'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mqout() {
  integer arg_num
  local my_cmd

  __my-check-args $*
  (( $? )) && return 1

  my_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $my_cmd
  print "Query\n"

  my_cmd=$my_cmd" | xargs -0 -i ${MYSQL_CMD} '{}' -N | sed -e 's/\t/,/g' >! $TMP"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

myfindg() {
  local my_cmd cmd_res_field_list cmd_res_field_name table_name field_name tmp_line usage opt

  usage="usage: $0 [-f 'Part of field info'] [-t 'Part of table name']"
  while getopts :f:t: opt; do
    case ${opt} in
      f) field_name=${OPTARG} ;;
      t) table_name=${OPTARG} ;;
      :|\?) print $usage; return 1 ;;
    esac
  done

  tmp_line="-------------------------------------------------------"
  my_cmd=$MYSQL_CMD
  if (( ${#table_name} && ${#field_name} )); then
    print "Field\tType\tNull\tKey\tDefault\tExtra\n${tmp_line}"
    eval $my_cmd" 'DESC ${table_name}' -N | grep --color '${field_name}'"
  elif (( ${#table_name} )); then
    print "Tables\n${tmp_line}"
    eval $my_cmd" 'SHOW TABLES' -N | grep --color '${table_name}'"
  elif (( ${#field_name} )); then
    print "Table: 'name'\nField\tType\tNull\tKey\tDefault\tExtra\n${tmp_line}"
    for table_name in $(eval $my_cmd" 'SHOW TABLES' -N"); do
      cmd_res_field_list=$(eval $my_cmd" 'DESC ${table_name}' -N | grep --color '${field_name}'")
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

mqexp() {
  integer arg_num
  local my_cmd

  __my-check-args $*
  (( $? )) && return 1

  my_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${*[$arg_num]}/g'"
  done

  print "<<Query"
  eval $my_cmd
  print "Query\n"

  my_cmd=$my_cmd" | xargs -0 -i ${MYSQL_CMD} 'EXPLAIN {}\G'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mydesc() {
  __my-check-presence-of-args $*
  (( $? )) && return 1

  eval "${MYSQL_CMD} 'DESC ${1}'"
}

myindex() {
  __my-check-presence-of-args $*
  (( $? )) && return 1

  eval "${MYSQL_CMD} 'SHOW INDEX FROM ${1}'"
}

myfcsv() {
  __my-check-presence-of-args $*
  (( $? )) && return 1

  eval "${MYSQL_CMD} 'DESC ${1}' -N | sed s/$'\t'.*//g | xargs echo | sed -e 's/ /,/g'"
}

mycnt() {
  __my-check-presence-of-args $*
  (( $? )) && return 1

  eval "${MYSQL_CMD} 'SELECT COUNT(1) FROM ${1}'"
}

watch-myps() {
  local opt full_opt g_opt usage

  usage="usage: $0 [-f(FULL PROCESSLIST)] [-g(\\G)]"
  while getopts :fgh opt; do
    case ${opt} in
      f) full_opt='FULL' ;;
      g) g_opt='\G' ;;
      h|:|\?) print $usage; return 2 ;;
    esac
  done

  watch -n 3 "${MYSQL_CMD} 'SHOW ${full_opt} PROCESSLIST${g_opt}'"
}

mf() {
  local -a params
  local my_cmd priority_condition group_condition limit_condition order_condition selected_field_list vertical_option where_condition table_name self_cmd help usage

  self_cmd=$0
  help="Try \`$self_cmd --help' for more information."
  usage=`cat <<EOF
usage: $self_cmd <table name>
          [-c --primary-condition <highest priority condition>]
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
      --primary-condition | -c)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        priority_condition=" $2"
        shift 2
        ;;
      --group-by | -g)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        group_condition=" GROUP BY $2"
        shift 2
        ;;
      --limit | -l)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        limit_condition=" LIMIT $2"
        shift 2
        ;;
      --order-by | -o)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        order_condition=" ORDER BY $2"
        shift 2
        ;;
      --select | -s)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        selected_field_list=" $2"
        shift 2
        ;;
      --vertical | -v)
        vertical_option='\G'
        shift 1
        ;;
      --where | -w)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        where_condition=" WHERE $2"
        shift 2
        ;;
      --help | -h)
        print $usage
        return 0
        ;;
      -- | -) # Stop option processing
        shift;
        params+=("$@")
        break
        ;;
      -*)
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
        return 1
        ;;
      *)
        params+=("$1")
        shift 1
        ;;
    esac
  done

  if (( ! $#params )); then
    print $usage
    return 1
  fi
  table_name=" ${params[1]}"

  (( ! $#selected_field_list )) && selected_field_list=' *'

  if (( $#priority_condition )); then
    my_cmd="SELECT${selected_field_list} FROM${table_name}${priority_condition}"
  else
    my_cmd="SELECT${selected_field_list} FROM${table_name}${where_condition}${group_condition}${order_condition}${limit_condition}${vertical_option}"
  fi

  print "> $my_cmd;"
  eval $MYSQL_CMD "'$my_cmd'"
}
