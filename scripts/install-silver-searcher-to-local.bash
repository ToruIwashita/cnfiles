#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $THE_SILVER_SEARCHER_SRC_DIR_PATH

./build.sh --prefix=$LOCAL_DIR_PATH
make install PREFIX=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
