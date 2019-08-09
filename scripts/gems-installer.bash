#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which ruby)} =~ anyenv ]]; then
  printf "there is no ruby installed with anyenv\n"
  exit 1
fi

printf "gem: $(gem --version)\n"

echo
which gem

echo
rbenv exec gem update --system

echo
rbenv exec gem install bundler
rbenv exec gem install rails
rbenv exec gem install aws-sdk
rbenv exec gem install rspec
rbenv exec gem install pry
rbenv exec gem install pry-doc
rbenv exec gem install pry-byebug
rbenv exec gem install pry-remote
rbenv exec gem install pry-stack_explorer
rbenv exec gem install pry-rails
rbenv exec gem install rubocop
rbenv exec gem install rubocop-rspec
rbenv exec gem install awesome_print
rbenv exec gem install sqlint

echo
rbenv exec gem update

echo
rbenv rehash

echo
printf "complete\n"

exit 0
