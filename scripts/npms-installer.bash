#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which npm)} =~ anyenv ]]; then
  printf "there is no npm installed with anyenv\n"
  exit 1
fi

printf "npm: $(npm --version)\n"

# install for global
nodenv exec npm -g install vue-cli
nodenv exec npm -g install eslint
nodenv exec npm -g install eslint-plugin-import
nodenv exec npm -g install eslint-plugin-vue
nodenv exec npm -g install eslint-config-vue
nodenv exec npm -g install babel-eslint
nodenv exec npm -g install stylelint
nodenv exec npm -g install stylelint-config-standard
nodenv exec npm -g install stylelint-processor-html
nodenv exec npm -g install lice

nodenv exec npm update vue-cli
nodenv exec npm update eslint
nodenv exec npm update eslint-plugin-import
nodenv exec npm update eslint-plugin-vue
nodenv exec npm update eslint-config-vue
nodenv exec npm update babel-eslint
nodenv exec npm update stylelint
nodenv exec npm update stylelint-config-standard
nodenv exec npm update stylelint-processor-html
nodenv exec npm update lice

printf "\ncomplete\n"
exit 0
