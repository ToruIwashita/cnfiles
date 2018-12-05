#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which python3)} =~ anyenv ]]; then
  printf "there is no python3 installed with anyenv\n"
  exit 1
fi

printf "pip3: $(pip3 --version)\n"

echo
which pip3

echo
printf "install or update pyps using pyenv exec\n"

echo
pyenv exec pip3 install -U pipenv
pyenv exec pip3 install -U django
pyenv exec pip3 install -U awscli
pyenv exec pip3 install -U vim-vint
pyenv exec pip3 install -U flake8
pyenv exec pip3 install -U autopep8
pyenv exec pip3 install -U ipython
pyenv exec pip3 install -U wheel

echo
pyenv rehash

echo
printf "complete\n"

exit 0
