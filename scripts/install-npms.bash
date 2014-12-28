#!/usr/bin/env bash

# install dir
NPM_HOME=~/.npm

npm -g install jshint --prefix=$NPM_HOME
npm update jshint

printf "\ncomplete\n"
exit 0
