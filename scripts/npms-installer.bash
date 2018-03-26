#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which npm)} =~ anyenv ]]; then
  printf "there is no npm installed with anyenv\n"
  exit 1
fi

printf "npm: $(npm --version)\n"

# install for global
npm -g install jshint
npm -g install lice

npm update jshint
npm update lice

printf "\ncomplete\n"
exit 0
