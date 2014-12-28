#!/usr/bin/env bash

# install dir
CNBUNDLE_NODEJS_DIR_PATH=~/.cnbundle/node

npm -g install jshint --prefix=$CNBUNDLE_NODEJS_DIR_PATH
npm update jshint

printf "\ncomplete\n"
exit 0
