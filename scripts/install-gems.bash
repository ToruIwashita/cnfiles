#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

ruby -v
echo
printf "GEM_HOME: $GEM_HOME\n"

gem install bundler
gem install rails
gem install pry 
gem install pry-byebug
gem install pry-remote 
gem install rubocop
gem install rspec
gem install awesome_print

gem update bundler
gem update rails
gem update pry
gem update pry-byebug
gem update pry-remote 
gem update rubocop
gem update rspec
gem update awesome_print

printf "\ncomplete\n"
exit 0
