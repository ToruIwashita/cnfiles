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
printf "\e[32mnpm install -g eslint\e[0m\n"
npm install -g eslint

echo
printf "\e[32mnpm install -g prettier\e[0m\n"
npm install -g prettier

echo
printf "\e[32mnpm install -g babel-eslint\e[0m\n"
npm install -g babel-eslint

echo
printf "\e[32mnpm install -g eslint-plugin-prettier\e[0m\n"
npm install -g eslint-plugin-prettier

echo
printf "\e[32mnpm install -g eslint-config-prettier\e[0m\n"
npm install -g eslint-config-prettier

echo
printf "\e[32mnpm install -g fixjson\e[0m\n"
npm install -g fixjson

echo
printf "\e[32mnpm install -g lice\e[0m\n"
npm install -g lice

echo
printf "\e[32mnpm install -g @redocly/cli\e[0m\n"
npm install -g @redocly/cli

echo
printf "\e[32mnpm install -g swagger-merger\e[0m\n"
npm install -g swagger-merger

echo
printf "\e[32mnpm install -g @mermaid-js/mermaid-cli\e[0m\n"
npm install -g @mermaid-js/mermaid-cli

echo
printf "\e[32mnpm install -g @anthropic-ai/claude-code\e[0m\n"
npm install -g @anthropic-ai/claude-code

echo
printf "\e[32mnpm install -g @google/gemini-cli\e[0m\n"
npm install -g @google/gemini-cli

asdf reshim nodejs

echo
printf "\ncomplete\n"

exit 0
