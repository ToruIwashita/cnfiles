#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# nodejs src dir
NODEJS_SRC_DIR_PATH=$BASE_DIR_PATH/modules/node
# install dir
LOCAL_DIR_PATH=~/local

cd $NODEJS_SRC_DIR_PATH

./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
