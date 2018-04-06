#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which npm)} =~ anyenv ]]; then
  printf "there is no npm installed with anyenv\n"
  exit 1
fi

printf "npm: $(npm --version)\n"

# install for global
nodenv exec npm -g install jshint
nodenv exec npm -g install lice

nodenv exec npm update jshint
nodenv exec npm update lice

printf "\ncomplete\n"
exit 0
