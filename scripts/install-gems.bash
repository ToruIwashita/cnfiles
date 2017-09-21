#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

ruby -v

echo
which gem

echo
printf "install gems using rbenv exec"

echo
rbenv exec gem install bundler
rbenv exec gem install aws-sdk
rbenv exec gem install rails
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

echo
printf "update gems using rbenv exec"

echo
rbenv exec gem update bundler
rbenv exec gem update aws-sdk
rbenv exec gem update rails
rbenv exec gem update rspec
rbenv exec gem update pry
rbenv exec gem update pry-doc
rbenv exec gem update pry-byebug
rbenv exec gem update pry-remote
rbenv exec gem update pry-stack_explorer
rbenv exec gem update pry-rails
rbenv exec gem update rubocop
rbenv exec gem install rubocop-rspec
rbenv exec gem update awesome_print

echo
rbenv rehash

echo
printf "complete"

exit 0
