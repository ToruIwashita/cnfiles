## 標準出力関連関数
csconv() {
  if [[ $# -lt 1 ]]; then
    print "lack of arguments." 2>&1
    return 1
  fi  

  echo ${(j:,:)$(cat $1)}
}
