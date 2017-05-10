#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $ZSH_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/zsh ]]; then
  mv $LOCAL_BIN_DIR_PATH/{zsh,zsh.prev}
fi

./Util/preconfig
./configure                                     \
  --prefix=$LOCAL_DIR_PATH                      \
  --enable-cflags="-I$LOCAL_INCLUDE_DIR_PATH"   \
  --enable-cppflags="-I$LOCAL_INCLUDE_DIR_PATH" \
  --enable-ldflags="-L$LOCAL_LIB_DIR_PATH"      \
  --enable-multibyte --enable-locale
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
