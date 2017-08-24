#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

python --version

echo
which pip

echo
printf "install pyps using pyenv exec"

echo
pyenv exec pip install awscli
pyenv exec pip install vim-vint

echo
printf "update pyps using pyenv exec"

echo
pyenv exec pip install -U awscli
pyenv exec pip install -U vim-vint

echo
pyenv rehash

echo
printf "complete"

exit 0
