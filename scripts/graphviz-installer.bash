#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $GRAPHVIZ_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/dot ]]; then
  mv $LOCAL_BIN_DIR_PATH/{dot,dot.prev}
fi

./autogen.sh
./configure --prefix=$LOCAL_DIR_PATH

make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
