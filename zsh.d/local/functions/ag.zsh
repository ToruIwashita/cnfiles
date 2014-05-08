## ag関数(引数順序替え)
function ag() {
  if [[ $# -lt 2 ]]; then
    print "lack of arguments."
    return 1
  fi  

  eval "$AG_BIN $2 $1"
}
