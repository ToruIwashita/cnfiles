#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

cd $THE_SILVER_SEARCHER_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/ag  ]]; then
  mv $LOCAL_BIN_DIR_PATH/{ag,ag.prev}
fi

./build.sh --prefix=$LOCAL_DIR_PATH
make install PREFIX=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
