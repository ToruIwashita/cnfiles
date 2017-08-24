## pgsql関連関数
pg() {
  __pg-connect
}

pgq() {
  __pg-cmd $*
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

  pg_cmd=$pg_cmd" | xargs -0 -i $(__pg-cmd-self) '{}' -t | sed -e 's/\t/,/g' >! $TMP"
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
