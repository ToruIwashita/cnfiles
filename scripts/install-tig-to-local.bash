#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# tig src dir
TIG_SRC_DIR_PATH=$BASE_DIR_PATH/modules/tig
# install dir
LOCAL_DIR_PATH=~/local

cd $TIG_SRC_DIR_PATH

make
make install prefix=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
