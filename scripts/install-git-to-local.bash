#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

cd $GIT_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/git ]]; then
  mv $LOCAL_BIN_DIR_PATH/{git,git.prev}
fi

make configure
./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
