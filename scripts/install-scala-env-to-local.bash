#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ -L ~/.scalaenv ]]; then
  printf "\e[32m~/.scalaenv dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.scalaenv dir\e[0m\n"
  ln -isn $SCALAENV_SRC_DIR_PATH ~/.scalaenv
fi

if [[ -L ~/.sbtenv ]]; then
  printf "\e[32m~/.sbtenv dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.sbtenv dir\e[0m\n"
  ln -isn $SBTENV_SRC_DIR_PATH ~/.sbtenv
fi

printf "\ncomplete\n"
exit 0
