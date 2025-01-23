#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which npm) =~ asdf ]]; then
  printf "there is no npm installed with asdf\n"
  exit 1
fi

printf "npm: $(npm --version)\n"

echo
which npm

echo
npm update

echo
npm install -g npm
npm install -g eslint
npm install -g prettier
npm install -g babel-eslint
npm install -g eslint-plugin-prettier
npm install -g eslint-config-prettier
npm install -g fixjson
npm install -g lice
npm install -g @mermaid-js/mermaid-cli

echo
npm update -g

asdf reshim nodejs

echo
printf "\ncomplete\n"

exit 0
