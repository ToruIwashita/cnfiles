## find&grep
findg() {
  if (( $# < 2 )); then
    print 'lack of arguments.' 1>&2
    return 1
  fi

  find $2 -print0 | xargs -0 grep --color $1 -n$3
}
