#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# Xquartz(X11)
XQUARTZ_PATH=$(which Xquartz)
XQUARTZ_INCLUDE_PATH="${XQUARTZ_PATH%/bin*}/include"

if [[ $XQUARTZ_PATH == '' ]]; then
  printf "there is no Xquartz installed\n"
  exit 1
fi

cd $GRAPHVIZ_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/dot ]]; then
  mv $LOCAL_BIN_DIR_PATH/{dot,dot.prev}
fi

./autogen.sh
./configure \
  --prefix=$LOCAL_DIR_PATH \
  CPPFLAGS=-I$XQUARTZ_INCLUDE_PATH
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
