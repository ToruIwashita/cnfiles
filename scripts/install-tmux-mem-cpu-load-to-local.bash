#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts}
CURRENT_DIR=`pwd`
# tmux src dir
TMUX_MEM_CPU_LOAD_SRC_DIR_PATH=$BASE_DIR_PATH/modules/tmux-mem-cpu-load
# install dir
LOCAL_DIR_PATH=~/local

cd $TMUX_MEM_CPU_LOAD_SRC_DIR_PATH

cmake -DCMAKE_INSTALL_PREFIX=$LOCAL_DIR_PATH .
make && make install

printf "\ncomplete\n"
exit 0
