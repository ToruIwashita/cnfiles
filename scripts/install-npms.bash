#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# install for global
npm -g install jshint
npm -g install lice

npm update jshint
npm update lice

printf "\ncomplete\n"
exit 0
