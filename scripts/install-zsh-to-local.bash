#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts}
CURRENT_DIR=`pwd`
# zsh src dir
ZSH_SRC_DIR_PATH=$BASE_DIR_PATH/modules/zsh
# install dir
LOCAL_DIR_PATH=~/local

cd $ZSH_SRC_DIR_PATH

./Util/preconfig
./configure                                     \
  --prefix=$LOCAL_DIR_PATH                      \
  --enable-cflags="-I$LOCAL_DIR_PATH/include"   \
  --enable-cppflags="-I$LOCAL_DIR_PATH/include" \
  --enable-ldflags="-L$LOCAL_DIR_PATH/lib"      \
  --enable-multibyte --enable-locale
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
