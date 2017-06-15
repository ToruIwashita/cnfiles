#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ -L ~/.pyenv ]]; then
  printf "\e[32m~/.pyenv dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.pyenv dir\e[0m\n"
  ln -isn $PYENV_SRC_DIR_PATH ~/.pyenv
fi

printf "\ncomplete\n"
exit 0
