## 標準出力
csconv() {
  if (( ! $# )); then
    print "lack of arguments." 2>&1
    return 1
  fi

  print ${(j:,:)$(cat $1)}
}
