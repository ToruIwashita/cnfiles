## sbtenv関連関数
sbtsw() {
  sbtenv global $1
  rbenv rehash
  add-sbt-setting
}

add-sbt-setting() {
  local dir_path=~/.sbt/${${${(M)"$(sbtenv version)"#* }#*-}%.*}

  ln -is $CNFILES_DIR_PATH/sbt/global.sbt $dir_path/global.sbt
}