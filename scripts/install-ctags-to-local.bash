#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $CTAGS_SRC_DIR_PATH

autoreconf
./configure --prefix=$LOCAL_DIR_PATH
make
make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
