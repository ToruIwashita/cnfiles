#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# install for global
npm -g install jshint --prefix=$NPM_HOME
npm -g install coffeelint --prefix=$NPM_HOME
npm -g install lice --prefix$NPM_HOME

npm update jshint
npm update coffeelint
npm update lice

printf "\ncomplete\n"
exit 0
