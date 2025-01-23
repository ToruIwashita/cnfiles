#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which python3) =~ asdf ]]; then
  printf "there is no python3 installed with asdf\n"
  exit 1
fi

printf "pip3: $(pip3 --version)\n"

echo
which pip3

echo
pip3 install --upgrade pip

echo
pip3 install -U pipenv
pip3 install -U vim-vint
pip3 install -U sqlparse
pip3 install -U flake8
pip3 install -U mypy
pip3 install -U black
pip3 install -U isort
pip3 install -U ipython
pip3 install -U wheel
pip3 install -U pynvim

asdf reshim python

echo
printf "complete\n"

exit 0
