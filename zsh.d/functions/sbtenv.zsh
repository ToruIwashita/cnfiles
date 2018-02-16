## sbtenv関連関数
sbtsw() {
  sbtenv global $1
  sbtenv rehash
  add-sbt-setting
}

add-sbt-setting() {
  local dir_path=~/.sbt/${${${(M)"$(sbtenv version)"#* }#*-}%.*}

  if [[ -d $dir_path ]]; then
    printf "\e[32m$dir_path dir already exists\e[0m\n"
  else
    printf "\e[31mmkdir $dir_path\e[0m\n"
    mkdir -p $dir_path
  fi

  if [[ -L $dir_path/global.sbt ]]; then
    printf "\e[32m$dir_path/global.sbt symlink already exists\e[0m\n"
  else
    printf "\e[31mcreate symlink $dir_path/global.sbt\e[0m\n"
    ln -is $CNFILES_DIR_PATH/sbt/global.sbt $dir_path/global.sbt
  fi
}
