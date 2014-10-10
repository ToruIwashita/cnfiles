#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts}
CURRENT_DIR=`pwd`
# ctags src dir
CTAGS_SRC_DIR_PATH=$BASE_DIR_PATH/modules/ctags
# install dir
LOCAL_DIR_PATH=~/local

cd $CTAGS_SRC_DIR_PATH

autoreconf
./configure --prefix=$LOCAL_DIR_PATH
make
make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
