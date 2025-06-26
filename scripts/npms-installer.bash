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
printf 'npm install -g eslint'
npm install -g eslint

printf 'npm install -g prettier'
npm install -g prettier

printf 'npm install -g babel-eslint'
npm install -g babel-eslint

printf 'npm install -g eslint-plugin-prettier'
npm install -g eslint-plugin-prettier

printf 'npm install -g eslint-config-prettier'
npm install -g eslint-config-prettier

printf 'npm install -g fixjson'
npm install -g fixjson

printf 'npm install -g lice'
npm install -g lice

printf 'npm install -g @redocly/cli'
npm install -g @redocly/cli

printf 'npm instlal -g swagger-merger'
npm instlal -g swagger-merger

printf 'npm install -g @mermaid-js/mermaid-cli'
npm install -g @mermaid-js/mermaid-cli

printf 'npm install -g @anthropic-ai/claude-code'
npm install -g @anthropic-ai/claude-code

printf 'npm install -g @google/gemini-cli'
npm install -g @google/gemini-cli

asdf reshim nodejs

echo
printf "\ncomplete\n"

exit 0
