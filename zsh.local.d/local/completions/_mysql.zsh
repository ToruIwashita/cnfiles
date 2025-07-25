## mysql
__my-table-names() {
  compadd $(__my-table-list)
}

__my-limits() {
  compadd 1
}

_mf() {
  _arguments \
    '(-a --id-asc)'{-a,--id-asc}'[Order by id asc]' \
    '(-c --primary-condition)'{-c,--primary-condition}'[Highest priority condition]' \
    '(-d --id-desc)'{-d,--id-desc}'[Order by id desc]' \
    '(-g --group-by)'{-g,--group-by}'[Group condition]' \
    '(-l --limit)'{-l,--limit}'[Limit value]: :__my-limits' \
    '(-o --order-by)'{-o,--order-by}'[Order condition]' \
    '(-s --select)'{-s,--select}'[Select fields]' \
    '(-v --vertical)'{-v,--vertical}'[Vertical output]' \
    '(-w --where)'{-w,--where}'[Where condition]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :__my-table-names'
}

_mq() {
  _arguments \
    '(-t --tmp-sql)'{-t,--tmp-sql}'[Use temporary sql]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :_files'
}

_myfindg() {
  _arguments \
    -t'[Table name]:Input a part of table name or table name:__my-table-names' \
    -f'[Field info]:A part of field info'
}

_myg() {
  _arguments \
    -t'[Table name]:Input a part of table name or table name:__my-table-names' \
    -f'[Field name]:A part of field info' \
    -v'[Vertical output]' \
    -h'[Show help text]'
}

_watch-myps() {
  _arguments \
    -g'[with \\G suffix]' \
    -h'[Show help text]'
}

_my-tables() {
  _arguments '(:)*: :__my-table-names'
}

compdef _mf mf
compdef _mq mq
compdef _mq mqout
compdef _mq mqexp
compdef _myfindg myfindg
compdef _myg myg
compdef _my-tables mytable
compdef _my-tables mydesc
compdef _my-tables myindex
compdef _my-tables myctable
compdef _my-tables myfcsv
compdef _my-tables mycnt
compdef _watch-myps watch-myps
