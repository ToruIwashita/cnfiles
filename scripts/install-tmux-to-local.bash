#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts}
CURRENT_DIR=`pwd`
# tmux src dir
TMUX_SRC_DIR_PATH=$BASE_DIR_PATH/modules/tmux-code
# install dir
LOCAL_DIR_PATH=~/local

cd $TMUX_SRC_DIR_PATH

./autogen.sh
./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
