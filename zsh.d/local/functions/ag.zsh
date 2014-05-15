## ag関数(引数順序替え)
ag() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi  

  eval "$AG_BIN $2 $1"
}
