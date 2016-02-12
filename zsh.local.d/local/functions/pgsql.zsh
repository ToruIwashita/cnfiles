## PGSQL
__pg-check-argv() {
  if (( ! $# )); then
    print "lack of arguments." 2>&1
    return 1
  fi

  if [[ $1:e != "sql" ]]; then
    print "invalid extension." 2>&1
    return 1
  fi

  return 0
}

pq() {
  integer arg_num
  local pg_cmd

  __pg-check-argv $argv
  if (( $? )); then
    return 1
  fi

  pg_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${argv[arg_num]}/g'"
  done

  print "<<Q"
  eval $pg_cmd
  print "Q\n"

  pg_cmd=$pg_cmd" | xargs -0 -i ${PGSQL_CMD} '{}'"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pqout() {
  integer arg_num
  local pg_cmd

  __pg-check-argv $argv
  if (( $? )); then
    return 1
  fi

  pg_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${argv[arg_num]}/g'"
  done

  print "<<Q"
  eval $pg_cmd
  print "Q\n"

  pg_cmd=$pg_cmd" | xargs -0 -i ${PGSQL_CMD} '{}' -N | sed -e 's/\t/,/g' >! ~/works/tmp.txt"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pqexp() {
  integer arg_num
  local pg_cmd

  __pg-check-argv $argv
  if (( $? )); then
    return 1
  fi

  pg_cmd="cat $1"
  for ((i=1; i<$#; i++)); do
    arg_num=$(expr $i + 1)
    pg_cmd=$pg_cmd" | sed -e 's/\${$i}/${argv[arg_num]}/g'"
  done

  print "<<Q"
  eval $pg_cmd
  print "Q\n"

  pg_cmd=$pg_cmd" | xargs -0 -i ${PGSQL_CMD} 'EXPLAIN {}'"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pgdesc() {
  if (( ! $# )); then
    print "lack of arguments." 2>&1
    return 1
  fi

  eval "${PGSQL_CMD} '\d ${1}'"
}
