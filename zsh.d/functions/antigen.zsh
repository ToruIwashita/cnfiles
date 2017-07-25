## antigen関連
ant-install() {
  antigen reset
  exec $SHELL -l
}

ant-update() {
  antigen selfupdate
  antigen update
  antigen reset
  antigen cache-gen
}

ant-clean() {
  antigen cleanup --force
  ant-install
}
