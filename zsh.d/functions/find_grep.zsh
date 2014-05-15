## find&grep関数
findg() {
  if [[ $# -lt 2 ]]; then
    print "lack of arguments."
    return 1
  fi  

  find $2 -print0 | xargs -0 grep --color $1 -n$3
}
