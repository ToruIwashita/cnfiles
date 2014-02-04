## 標準出力関連関数
function csconv() {
  if [ $# -lt 1 ]; then
    print "lack of arguments."
    return 1
  fi  

  echo ${(j:,:)$(cat $1)}
}
