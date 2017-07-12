#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

python -v

echo
printf "install gems using rbenv exec"

echo
rbenv exec gem install bundler

echo
printf "update gems using rbenv exec"

echo
rbenv exec gem update awesome_print

echo
pyenv rehash

echo
printf "complete"

exit 0
