#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# luajit src dir
SRC_DIR_PATH=$BASE_DIR_PATH/modules/luajit-2.0
# install dir
LOCAL_DIR_PATH=~/local

set -e

cd $SRC_DIR_PATH

make
make install PREFIX=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
