#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $JQ_SRC_DIR_PATH

autoreconf -i
./configure                 \
  --prefix=$LOCAL_DIR_PATH  \
  --disable-maintainer-mode
make -j8
make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
