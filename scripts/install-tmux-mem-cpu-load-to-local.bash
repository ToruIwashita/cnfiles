#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $TMUX_MEM_CPU_LOAD_SRC_DIR_PATH

cmake -DCMAKE_INSTALL_PREFIX=$LOCAL_DIR_PATH .
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
