#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ -d $RBENV_SRC_DIR_PATH/plugins ]]; then
  printf "\e[32m$RBENV_SRC_DIR_PATH/plugins dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $RBENV_SRC_DIR_PATH/plugins\e[0m\n"
  mkdir $RBENV_SRC_DIR_PATH/plugins
fi

if [[ -L ~/.rbenv ]]; then
  printf "\e[32m~/.rbenv dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.rbenv dir\e[0m\n"
  ln -isn $RBENV_SRC_DIR_PATH ~/.rbenv
fi

if [[ -L ~/.rbenv/plugins/ruby-build ]]; then
  printf "\e[32m~/.rbenv/plugins/ruby-build dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.rbenv/plugins/ruby-build dir\e[0m\n"
  ln -isn $RUBY_BUILD_SRC_DIR_PATH ~/.rbenv/plugins/ruby-build
fi

printf "\ncomplete\n"
exit 0
