#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which npm)} =~ anyenv ]]; then
  printf "there is no npm installed with anyenv\n"
  exit 1
fi

printf "npm: $(npm --version)\n"

# install for global
nodenv exec npm install -g npm
nodenv exec npm install -g nuxt
nodenv exec npm install -g electron
nodenv exec npm install -g vue-cli
nodenv exec npm install -g eslint
nodenv exec npm install -g eslint-plugin-vue
nodenv exec npm install -g babel-eslint
nodenv exec npm install -g lice

nodenv exec npm update -g

printf "\ncomplete\n"
exit 0
