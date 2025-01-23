#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which ruby) =~ asdf ]]; then
  printf "there is no ruby installed with asdf\n"
  exit 1
fi

if [[ ! $(which gem) =~ asdf ]]; then
  printf "there is no gem installed with asdf\n"
  exit 1
fi

printf "gem: $(gem --version)\n"

echo
which gem

echo
gem update --system

echo
gem install aws-sdk
gem install bundler
gem install foreman
gem install git-gsub
gem install pry
gem install pry-byebug
gem install pry-doc
gem install pry-rails
gem install pry-remote
gem install pry-stack_explorer
gem install rails
gem install rspec
gem install rubocop
gem install rubocop-rails
gem install rubocop-rspec
gem install sqlint
gem install yard

echo
gem update bundler

asdf reshim ruby

echo
printf "complete\n"

exit 0
