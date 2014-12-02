#!/usr/bin/env bash

# install dir
CNBUNDLE_RUBY_DIR_PATH=~/.cnbundle/ruby
export GEM_HOME=$CNBUNDLE_RUBY_DIR_PATH 

gem install pry 
gem install rubocop
gem install rspec

printf "\ncomplete\n"
exit 0
