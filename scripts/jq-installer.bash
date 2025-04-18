#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $JQ_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/jq ]]; then
  mv $LOCAL_BIN_DIR_PATH/{jq,jq.prev}
fi

git submodule update --init
autoreconf -fi
./configure                 \
  --prefix=$LOCAL_DIR_PATH  \
  --with-oniguruma=builtin  \
  --disable-maintainer-mode
make -j8
make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
