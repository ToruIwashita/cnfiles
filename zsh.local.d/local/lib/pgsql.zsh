## pgsql
__pg-check-args() {
  if (( ! $# )); then
    print 'lack of arguments.' 2>&1
    return 1
  fi

  return 0
}

__pg-connect() {
  psql $*
}

__pg-cmd() {
  __pg-connect -c $*
}

__pg-cmd-self() {
  echo "psql -c"
}

__pg-table-list() {
  __pg-cmd 'SELECT relname FROM pg_stat_user_tables' --tuples-only
}
