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
printf "install pyps using pyenv exec"

echo
pyenv exec pip3 install pipenv
pyenv exec pip3 install awscli
pyenv exec pip3 install vim-vint
pyenv exec pip3 install ipython
pyenv exec pip3 install git+https://github.com/Mic92/pry.py

echo
printf "update pyps using pyenv exec"

echo
pyenv exec pip3 install -U pipenv
pyenv exec pip3 install -U awscli
pyenv exec pip3 install -U vim-vint
pyenv exec pip3 install -U ipython
pyenv exec pip3 install -U git+https://github.com/Mic92/pry.py

echo
pyenv rehash

echo
printf "complete"

exit 0
