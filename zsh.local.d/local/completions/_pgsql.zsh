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

_pqout() {
  _arguments \
    '(-t --tmp-sql)'{-t,--tmp-sql}'[Use temporary sql]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :_files'
}

_pgfindg() {
  _arguments \
    -t'[Table name]:Input a part of table name or table name:__pg-table-names' \
    -f'[Field info]:A part of field info'
}

_pg-tables() {
  _arguments '(:)*: :__pg-table-names'
}

compdef _pq pq
compdef _pq pqout
compdef _pq pqexp
compdef _pgfindg pgfindg
compdef _pg-tables pgdesc
compdef _pg-tables pgfcsv
compdef _pg-tables pgcnt
