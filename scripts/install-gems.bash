#!/usr/bin/env bash

# install dir
GEM_HOME=~/.gem

set -e

gem install pry 
gem install rubocop
gem install rspec

gem update pry
gem update rubocop
gem update rspec

printf "\ncomplete\n"
exit 0
