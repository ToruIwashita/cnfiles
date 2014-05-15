## MYSQL
_my-check-argv() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  if [[ $1:e != "sql" ]]; then
    print "invalid extension."
    return 1
  fi

  return 0
}

mq() {
  local my_cmd arg_num

  _my-check-argv $argv
  if [[ $? -eq 1 ]]; then
    return 1
  fi

  my_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=`expr $i + 1`
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${argv[arg_num]}/g'"
  done

  print "<<Q"
  eval $my_cmd
  print "Q\n"

  my_cmd=$my_cmd" | xargs -0 -i ${MYSQL_CMD} '{}'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mqout() {
  local my_cmd arg_num

  _my-check-argv $argv
  if [[ $? -eq 1 ]]; then
    return 1
  fi

  my_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=`expr $i + 1`
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${argv[arg_num]}/g'"
  done

  print "<<Q"
  eval $my_cmd
  print "Q\n"

  my_cmd=$my_cmd" | xargs -0 -i ${MYSQL_CMD} '{}' -N | sed -e 's/\t/,/g' >! ~/works/tmp.txt"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

myfindg() {
  local my_cmd cmd_res_field_list cmd_res_field_name table_name field_name tmp_line myfindg_usage arg

  myfindg_usage="Usage: $0 [-f 'Part of field info'] [-t 'Part of table name']"
  while getopts :f:t: arg; do
    case ${arg} in
      f) field_name=${OPTARG} ;;
      t) table_name=${OPTARG} ;;
      :|\?) print $myfindg_usage; return 1 ;;
    esac
  done

  tmp_line="-------------------------------------------------------"
  my_cmd=$MYSQL_CMD
  if [[ ${#table_name} -gt 0 && ${#field_name} -gt 0 ]]; then
    print "Field\tType\tNull\tKey\tDefault\tExtra\n${tmp_line}"
    eval $my_cmd" 'DESC ${table_name}' -N | grep --color '${field_name}'"
  elif [[ ${#table_name} -gt 0 ]]; then
    print "Tables\n${tmp_line}"
    eval $my_cmd" 'SHOW TABLES' -N | grep --color '${table_name}'"
  elif [[ ${#field_name} -gt 0 ]]; then
    print "Table: 'name'\nField\tType\tNull\tKey\tDefault\tExtra\n${tmp_line}"
    for table_name in `eval $my_cmd" 'SHOW TABLES' -N"`; do
      cmd_res_field_list=`eval $my_cmd" 'DESC ${table_name}' -N | grep --color '${field_name}'"`
      if [[ ${#cmd_res_field_list} -gt 0 ]]; then
        print "Table: ${table_name}"
        for cmd_res_field_name in ${(f)cmd_res_field_list}; do
          print $cmd_res_field_name | grep --color "${field_name}"
        done
        print
      fi
    done
  else
    print $myfindg_usage
  fi
}

mqexp() {
  local my_cmd arg_num

  _my-check-argv $argv
  if [[ $? -eq 1 ]]; then
    return 1
  fi

  my_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=`expr $i + 1`
    my_cmd=$my_cmd" | sed -e 's/\${$i}/${argv[arg_num]}/g'"
  done

  print "<<Q"
  eval $my_cmd
  print "Q\n"

  my_cmd=$my_cmd" | xargs -0 -i ${MYSQL_CMD} 'EXPLAIN {}\G'"
  print "command: ${my_cmd}\n"
  eval $my_cmd
}

mydesc() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'DESC ${1}'"
}

myindex() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'SHOW INDEX FROM ${1}'"
}

myfcsv() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'DESC ${1}' -N | sed -e 's/\t.*//g' | xargs echo | sed -e 's/ /,/g'"
}

mycnt() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'SELECT COUNT(1) FROM ${1}'"
}

watch-myps() {
  local arg full_opt g_opt

  watch_myps_usage="Usage: $0 [-f(FULL PROCESSLIST)] [-g(\\G)]"
  while getopts :fgh arg; do
    case ${arg} in
      f) full_opt='FULL' ;;
      g) g_opt='\G' ;;
      h|:|\?) print $watch_myps_usage; return 2 ;;
    esac
  done

  watch -n 3 "${MYSQL_CMD} 'SHOW ${full_opt} PROCESSLIST${g_opt}'"
}

mf() {
  local my_cmd priority_condition group_condition limit_condition order_condition select_fields table_name vertical_option where_condition mf_usage arg

  mf_usage="Usage: $0 <-t 'Table name'>
         [-c 'Highest priority condition']
         [-g 'Group condition']
         [-l 'Limit value']
         [-o 'Order condition']
         [-s 'Select fields']
         [-v 'Vertical display']
         [-w 'Where condition']"

  while getopts :c:g:l:o:s:t:vw: arg; do
    case ${arg} in
      c) priority_condition=' '${OPTARG} ;;
      g) group_condition=' GROUP BY '${OPTARG} ;;
      l) limit_condition=' LIMIT '${OPTARG} ;;
      o) order_condition=' ORDER BY '${OPTARG} ;;
      s) select_fields=' '${OPTARG} ;;
      t) table_name=' '${OPTARG} ;;
      v) vertical_option='\G' ;;
      w) where_condition=' WHERE '${OPTARG} ;;
      :|\?) print $mf_usage; return 1 ;;
    esac
  done

  if [[ ${#table_name} -eq 0 ]]; then
    print $mf_usage
    return 1
  fi

  [[ ${#select_fields} -eq 0 ]]   && select_fields=' *'

  if [[ ${#priority_condition} -eq 0 ]]; then
    my_cmd="SELECT${select_fields} FROM${table_name}${where_condition}${group_condition}${order_condition}${limit_condition}${vertical_option}"
  else
    my_cmd="SELECT${select_fields} FROM${table_name}${priority_condition}"
  fi

  print "> $my_cmd;"
  eval $MYSQL_CMD "'$my_cmd'"
}
