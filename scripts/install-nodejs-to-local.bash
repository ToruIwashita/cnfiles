#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $NODE_SRC_DIR_PATH

./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
