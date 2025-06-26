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
printf 'npm install -g eslint\n'
npm install -g eslint

echo
printf 'npm install -g prettier\n'
npm install -g prettier

echo
printf 'npm install -g babel-eslint\n'
npm install -g babel-eslint

echo
printf 'npm install -g eslint-plugin-prettier\n'
npm install -g eslint-plugin-prettier

echo
printf 'npm install -g eslint-config-prettier\n'
npm install -g eslint-config-prettier

echo
printf 'npm install -g fixjson\n'
npm install -g fixjson

echo
printf 'npm install -g lice\n'
npm install -g lice

echo
printf 'npm install -g @redocly/cli\n'
npm install -g @redocly/cli

echo
printf 'npm install -g swagger-merger\n'
npm install -g swagger-merger

echo
printf 'npm install -g @mermaid-js/mermaid-cli\n'
npm install -g @mermaid-js/mermaid-cli

echo
printf 'npm install -g @anthropic-ai/claude-code\n'
npm install -g @anthropic-ai/claude-code

echo
printf 'npm install -g @google/gemini-cli\n'
npm install -g @google/gemini-cli

asdf reshim nodejs

echo
printf "\ncomplete\n"

exit 0
