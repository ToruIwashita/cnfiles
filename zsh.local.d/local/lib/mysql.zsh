## mysql
__my-check-args() {
  __check-presence-of-args $*
  (( $? )) && return 1
  __check-arg-suffix 'sql' $1
  (( $? )) && return 1

  return 0
}

__my-connect() {
  mysql $MYSQL_DATABASE $*
}

__my-cmd() {
  __my-connect -e $*
}

__my-cmd-self() {
  echo "mysql $MYSQL_DATABASE -e"
}

__my-table-list() {
  __my-cmd 'SHOW TABLES' -N
}
