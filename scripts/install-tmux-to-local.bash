#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# src dir
SRC_DIR_PATH=$BASE_DIR_PATH/modules/tmux-code
# install dir
LOCAL_DIR_PATH=~/local

set -e

cd $SRC_DIR_PATH

# backup
if [[ -f $LOCAL_DIR_PATH/bin/tmux ]]; then
  mv $LOCAL_DIR_PATH/bin/{tmux,tmux.prev}
fi

./autogen.sh
./configure --prefix=$LOCAL_DIR_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
