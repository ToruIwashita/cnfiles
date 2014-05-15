## find&grep関数
findg() {
  if [[ $# -lt 2 ]]; then
    print "lack of arguments."
    return 1
  fi  

  find $1 -print0 | xargs -0 grep --color $2 -n$3
}
