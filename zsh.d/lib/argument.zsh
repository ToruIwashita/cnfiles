## 引数チェック
__check-presence-of-args() {
  if (( ! $# )); then
    print 'lack of arguments.' 2>&1
    return 1
  fi

  return 0
}

__check-arg-suffix() {
  if [[ $1 != $2:e ]]; then
    print 'invalid extension.' 2>&1
    return 1
  fi

  return 0
}
