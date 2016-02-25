## PGSQL
__pg-check-presence-of-args() {
  if (( ! $# )); then
    print 'lack of arguments.' 2>&1
    return 1
  fi

  return 0
}

__pg-check-args() {
  __pg-check-presence-of-args $*
  (( $? )) && return 1

  if [[ $1:e != "sql" ]]; then
    print "invalid extension." 2>&1
    return 1
  fi

  return 0
}

pq() {
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

  pg_cmd=$pg_cmd" | xargs -0 -i ${PGSQL_CMD} '{}'"
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

  pg_cmd=$pg_cmd" | xargs -0 -i ${PGSQL_CMD} '{}' -t | sed -e 's/\t/,/g' >! $TMP"
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

  pg_cmd=$pg_cmd" | xargs -0 -i ${PGSQL_CMD} 'EXPLAIN {}'"
  print "command: ${pg_cmd}\n"
  eval $pg_cmd
}

pgdesc() {
  __pg-check-presence-of-args $*
  (( $? )) && return 1

  eval "${PGSQL_CMD} '\d ${1}'"
}
