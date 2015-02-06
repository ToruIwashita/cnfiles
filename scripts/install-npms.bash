#!/usr/bin/env bash

# install dir
NPM_HOME=~/.npm

set -e

npm -g install jshint --prefix=$NPM_HOME
npm -g install coffeelint --prefix=$NPM_HOME
npm -g install lice --prefix$NPM_HOME

npm update jshint
npm update coffeelint
npm update lice

printf "\ncomplete\n"
exit 0
