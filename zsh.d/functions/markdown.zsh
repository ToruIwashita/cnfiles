## markdown関連関数
pm() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  w3m -T text/html =(markdown $1)
}

pmout() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi

  print '<meta charset="utf-8">\n' >! $2
  markdown $1 >> $2
}
