## go
dlv-debug() {
  if (( $# != 1 )); then
    print 'invalid arguments.' 1>&2
    return 1
  fi

  dlv debug --log ./$1
}
