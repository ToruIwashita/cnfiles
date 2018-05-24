## pgsql関数用補完
__pg-table-names() {
  compadd $(__pg-table-list)
}

_pq() {
  _arguments \
    '(-t --tmp-sql)'{-t,--tmp-sql}'[Use temporary sql]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :_files'
}

_pg-tables() {
  _arguments '(:)*: :__pg-table-names'
}

compdef _pq pq
compdef _pg-tables pgdesc
