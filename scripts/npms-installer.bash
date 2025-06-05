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
npm update -g

echo
npm install -g eslint
npm install -g prettier
npm install -g babel-eslint
npm install -g eslint-plugin-prettier
npm install -g eslint-config-prettier
npm install -g fixjson
npm install -g lice
npm install -g @redocly/cli
npm instlal -g swagger-merger
npm install -g @mermaid-js/mermaid-cli
npm install -g @anthropic-ai/claude-code

asdf reshim nodejs

echo
printf "\ncomplete\n"

exit 0
