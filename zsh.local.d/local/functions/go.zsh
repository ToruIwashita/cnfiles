## go
ddlv() {
  if (( $# != 1 )); then
    print 'invalid arguments.' 1>&2
    return 1
  fi

  dlv debug --log ./$1
}

tgo() {
  if (( $# != 1 )); then
    print 'invalid arguments.' 1>&2
    return 1
  fi

  go test ./$1
}

tgo-fail() {
  if (( $# != 1 )); then
    print 'invalid arguments.' 1>&2
    return 1
  fi

  go test ./$1 | grep --color FAIL
}
