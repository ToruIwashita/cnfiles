## MYSQL用functions
function _my-check-argv() {
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

function mq() {
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

function mqout() {
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

function myfindg() {
  local my_cmd my_cmd_res_field_list my_cmd_res_field_name my_table_name my_field_name my_tmp_line myfindg_usage arg

  myfindg_usage="Usage: $0 [-f 'Part of field info'] [-t 'Part of table name']"
  while getopts :f:t: arg; do
    case ${arg} in
      f) my_field_name=${OPTARG} ;;
      t) my_table_name=${OPTARG} ;;
      :|\?) print $myfindg_usage; return 1 ;;
    esac
  done

  my_tmp_line="-------------------------------------------------------"
  my_cmd=$MYSQL_CMD
  if [[ ${#my_table_name} -gt 0 && ${#my_field_name} -gt 0 ]]; then
    print "Field\tType\tNull\tKey\tDefault\tExtra\n${my_tmp_line}"
    eval $my_cmd" 'DESC ${my_table_name}' -N | grep --color '${my_field_name}'"
  elif [[ ${#my_table_name} -gt 0 ]]; then
    print "Tables\n${my_tmp_line}"
    eval $my_cmd" 'SHOW TABLES' -N | grep --color '${my_table_name}'"
  elif [[ ${#my_field_name} -gt 0 ]]; then
    print "Table: 'name'\nField\tType\tNull\tKey\tDefault\tExtra\n${my_tmp_line}"
    for my_table_name in `eval $my_cmd" 'SHOW TABLES' -N"`; do
      my_cmd_res_field_list=`eval $my_cmd" 'DESC ${my_table_name}' -N | grep --color '${my_field_name}'"`
      if [[ ${#my_cmd_res_field_list} -gt 0 ]]; then
        print "Table: ${my_table_name}"
        for my_cmd_res_field_name in ${(f)my_cmd_res_field_list}; do
          print $my_cmd_res_field_name | grep --color "${my_field_name}"
        done
        print
      fi
    done
  else
    print $myfindg_usage
  fi
}

function mqexp() {
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

function mydesc() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'DESC ${1}'"
}

function myindex() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'SHOW INDEX FROM ${1}'"
}

function myfcsv() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'DESC ${1}' -N | sed -e 's/\t.*//g' | xargs echo | sed -e 's/ /,/g'"
}

function mycnt() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  eval "${MYSQL_CMD} 'SELECT COUNT(1) FROM ${1}'"
}

function watch-myps() {
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

function mf() {
  local mf_usage my_priority_condition my_g my_limit my_select_field my_order my_table_name my_condition arg

  mf_usage="Usage: $0 <-t 'Table name'>
         [-c 'Top priority condition']
         [-g '\G']
         [-l 'Limit value']
         [-o 'Order condition']
         [-s 'Select field']
         [-w 'Select condition']"
  while getopts :gl:s:t:w: arg; do
    case ${arg} in
      c) my_priority_condition=${OPTARG} ;;
      g) my_g='\G' ;;
      l) my_limit='LIMIT '${OPTARG} ;;
      s) my_select_field=${OPTARG} ;;
      o) my_order=${OPTARG} ;;
      t) my_table_name=${OPTARG} ;;
      w) my_condition=${OPTARG} ;;
      :|\?) print $mf_usage; return 1 ;;
    esac
  done

  if [[ ${#my_table_name} -eq 0 ]]; then
    print $mf_usage
    return 1
  fi

  [[ ${#my_condition} -eq 0 ]]    && my_condition='TRUE'
  [[ ${#my_select_field} -eq 0 ]] && my_select_field='*'

  if [[ ${#my_priority_condition} -eq 0 ]]; then
    "${MYSQL_CMD} 'SELECT ${my_select_field} FROM ${my_table_name} WHERE ${my_condition} ${my_order} ${my_limit} ${my_g}'"
  else
    "${MYSQL_CMD} 'SELECT ${my_select_field} FROM ${my_table_name} ${my_priority_condition}'"
  fi
}
