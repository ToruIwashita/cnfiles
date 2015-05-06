#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $TIG_SRC_DIR_PATH

make
make install prefix=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
