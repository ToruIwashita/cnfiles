#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $GH_CLI_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/gh ]]; then
  mv $LOCAL_BIN_DIR_PATH/{gh,gh.prev}
fi

git submodule update --init

make install prefix=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
