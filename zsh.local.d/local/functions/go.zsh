## go
ddlv() {
  if (( $# != 1 )); then
    print 'invalid arguments.' 1>&2
    return 1
  fi

  dlv debug --log ./$1
}

tgo() {
  if (( $# != 2 )); then
    print 'invalid arguments.' 1>&2
    return 1
  fi

  go test -json ./$1 | jq 'select(.Test == "'$2'")'
}
