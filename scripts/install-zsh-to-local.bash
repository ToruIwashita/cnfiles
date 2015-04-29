#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# zsh src dir
SRC_DIR_PATH=$BASE_DIR_PATH/modules/zsh
# install dir
LOCAL_DIR_PATH=~/local

set -e

cd $SRC_DIR_PATH

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
