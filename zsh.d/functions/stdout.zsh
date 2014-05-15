## 標準出力関連関数
csconv() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments."
    return 1
  fi  

  print ${(j:,:)$(cat $1)}
}
