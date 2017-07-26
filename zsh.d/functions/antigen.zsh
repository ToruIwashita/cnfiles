## antigen関連
ez() {
  antigen reset
  exec $SHELL -l
}

ant-install() {
  ez
}

ant-update() {
  antigen selfupdate
  antigen update
  antigen reset
  antigen cache-gen
}

ant-clean() {
  antigen cleanup --force
  ez
}
