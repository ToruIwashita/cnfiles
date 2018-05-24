## mysql関数用補完
__my-table-names() {
  compadd $(__my-table-list)
}

_mq() {
  _arguments \
    '(-t --tmp-sql)'{-t,--tmp-sql}'[Use temporary sql]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :_files'
}

_mf() {
  _arguments \
    '(-c --primary-condition)'{-c,--primary-condition}'[Highest priority condition]' \
    '(-g --group-by)'{-g,--group-by}'[Group condition]' \
    '(-l --limit)'{-l,--limit}'[Limit value]' \
    '(-o --order-by)'{-o,--order-by}'[Order condition]' \
    '(-s --select)'{-s,--select}'[Select fields]' \
    '(-v --vertical)'{-v,--vertical}'[Vertical display]' \
    '(-w --where)'{-w,--where}'[Where condition]' \
    '(-h --help)'{-h,--help}'[Show help text]' \
    '(:)*: :__my-table-names'
}

_myfindg() {
  _arguments \
    -t'[Table name]:Input a part of table name or table name:__my-table-names' \
    -f'[Field info]:A part of field info'
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
compdef _my-tables mytable
compdef _my-tables mydesc
compdef _my-tables myindex
compdef _my-tables myctable
compdef _my-tables myfcsv
compdef _my-tables mycnt
compdef _watch-myps watch-myps
