## mysql関連関数
my() {
  __my-connect
}

myq() {
  __my-cmd $*
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

  my_cmd=$my_cmd" | xargs -0 -i $(__my-cmd-self) '{}'"
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

  my_cmd=$my_cmd" | xargs -0 -i $(__my-cmd-self) '{}' -N | sed -e 's/\t/,/g' >! $MEMOLIST_TMP_FILE"
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
    myq "SHOW TABLES" -N | grep --color ${table_name}
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

  my_cmd=$my_cmd" | xargs -0 -i $(__my-cmd-self) 'EXPLAIN {}\G'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mytable() {
  __check-presence-of-args $*
  (( $? )) && return 1

  echo "> DESC $*;"
  mydesc $*
  echo "> SHOW INDEX FROM $*;"
  myindex $*
  echo "> SHOW CREATE TABLE $*\G"
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

  myq "DESC ${1}" -N | sed s/$'\t'.*//g | xargs echo | sed -e 's/ /,/g'
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
      -c | --primary-condition)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        priority_condition=" $2"
        shift 2
        ;;
      -g | --group-by)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        group_condition=" GROUP BY $2"
        shift 2
        ;;
      -l | --limit)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        limit_condition=" LIMIT $2"
        shift 2
        ;;
      -o | --order-by)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
          return 1
        fi
        order_condition=" ORDER BY $2"
        shift 2
        ;;
      -s | --select)
        if (( ! $#2 )) || [[ "$2" =~ ^-+ ]]; then
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
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
          print "$self_cmd: option requires an argument '$1'\n$help" 1>&2
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
        print "$self_cmd: unknown option '$1'\n$help" 1>&2
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
