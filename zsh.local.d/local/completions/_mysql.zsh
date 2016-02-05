## MYSQL関数用補完
__my-show-tables() {
  compadd $(eval "${MYSQL_CMD} 'SHOW TABLES' -N")
}

_myfindg() {
  _arguments \
    -t'[Table name]:Input a part of table name or table name:__my-show-tables' \
    -f'[Field info]:A part of field info'
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
    '(-h --help)'{-h,--help}'[Show this help text]' \
    '*: :__my-show-tables'
}

_myst() {
  _arguments '(:)*: :__my-show-tables'
}

compdef _myfindg myfindg
compdef _mf mf
compdef _myst mydesc
compdef _myst myindex
compdef _myst myfcsv
compdef _myst mycnt
