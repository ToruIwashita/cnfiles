#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

cd $NEOVIM_SRC_DIR_PATH

rm -rf build/ 
make distclean
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX:PATH=$LOCAL_DIR_PATH"
make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
