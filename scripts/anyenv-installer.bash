#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ -L ~/.anyenv ]]; then
  printf "\e[32m~/.anyenv dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.anyenv dir\e[0m\n"
  ln -isn $ANYENV_SRC_DIR_PATH ~/.anyenv
fi

printf "\ncomplete\n"
exit 0
