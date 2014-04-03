## double-accept-line
functions _test_hoge() {
  args=($(echo $BUFFER))
  exec < /dev/tty
  vim $args[2]
}

zle -N test_hoge _test_hoge
