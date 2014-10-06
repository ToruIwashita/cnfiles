#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts}
CURRENT_DIR=`pwd`
# luajit src dir
SILVER_SEARCHER_SRC_DIR_PATH=$BASE_DIR_PATH/modules/the_silver_searcher
# install dir
LOCAL_DIR_PATH=~/local

cd $SILVER_SEARCHER_SRC_DIR_PATH

./build.sh --prefix=$LOCAL_DIR_PATH
make install PREFIX=$LOCAL_DIR_PATH

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
