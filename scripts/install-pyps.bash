#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

python --version

echo
which pip3

echo
printf "install pyps using pyenv exec"

echo
pyenv exec pip3 install awscli
pyenv exec pip3 install vim-vint

echo
printf "update pyps using pyenv exec"

echo
pyenv exec pip3 install -U awscli
pyenv exec pip3 install -U vim-vint

echo
pyenv rehash

echo
printf "complete"

exit 0
