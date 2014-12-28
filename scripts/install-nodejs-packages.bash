#!/usr/bin/env bash

# install dir
NODE_HOME=~/.node

npm -g install jshint --prefix=$NODE_HOME
npm update jshint

printf "\ncomplete\n"
exit 0
