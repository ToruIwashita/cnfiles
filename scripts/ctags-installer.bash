#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $CTAGS_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/ctags ]]; then
  mv $LOCAL_BIN_DIR_PATH/{ctags,ctags.prev}
fi

LIBXML2_PATH=/usr/local/opt/libxml2

./autogen.sh
./configure                                     \
  --prefix=$LOCAL_DIR_PATH                      \
  --enable-iconv                                \
  --disable-external-sort                       \
  PKG_CONFIG_PATH="$LIBXML2_PATH/lib/pkgconfig" \
  LDFLAGS="-L$LIBXML2_PATH/lib"                 \
  CPPFLAGS="-I$LIBXML2_PATH/include"

make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
