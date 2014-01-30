## MYSQL関数用補完
function __my_show_tables() {
  compadd `eval "${MYSQL_CMD} 'SHOW TABLES' -N"`
}

function _myfindg() {
  _arguments : \
    '(:)-t[Table name]:Input a part of table name or table name:__my_show_tables' \
    '(:)-f[Field info]:A part of field info'
}

function _myst() {
  _arguments : \
    '(:)*:Input table name:__my_show_tables'
}

compdef _myfindg myfindg
compdef _myst mydesc
compdef _myst myindex
compdef _myst myfcsv
compdef _myst mycnt
