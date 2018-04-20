#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $GRAPHVIZ_SRC_DIR_PATH

make clean
./autogen.sh
./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
