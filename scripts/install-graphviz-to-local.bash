#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

cd $GRAPHVIZ_SRC_DIR_PATH

./autogen.sh
./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
