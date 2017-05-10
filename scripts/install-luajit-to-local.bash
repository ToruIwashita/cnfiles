#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $LUAJIT_SRC_DIR_PATH

make
make install PREFIX=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
