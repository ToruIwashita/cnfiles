#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

ruby -v
printf "GEM_HOME: $GEM_HOME\n"

gem install bundle 
gem install pry 
gem install pry-remote 
gem install rubocop
gem install rspec
gem install awesome_print

gem update bundle 
gem update pry
gem update pry-remote 
gem update rubocop
gem update rspec
gem update awesome_print

printf "\ncomplete\n"
exit 0
