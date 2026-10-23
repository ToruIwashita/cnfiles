#!/usr/bin/env bash

source "$(cd "$(dirname "$_")"; pwd)/env.bash"
set -e

if [[ ! $(which python3) =~ asdf ]]; then
  printf "there is no python3 installed with asdf\n"
  exit 1
fi

printf "pip3: %s\n" "$(pip3 --version)"

echo
which pip3

echo
pip3 install --upgrade pip

echo
pip3 install -U pipenv
# vint 0.3.21 は setuptools 82 で削除された pkg_resources を使う
pip3 install -U vim-vint 'setuptools<82'
pip3 install -U sqlparse
pip3 install -U flake8
pip3 install -U mypy
pip3 install -U black
pip3 install -U isort
pip3 install -U ipython
pip3 install -U wheel
pip3 install -U pynvim
pip3 install -U uv

asdf reshim python

echo
printf "complete\n"

exit 0
