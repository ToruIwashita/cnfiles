#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $TMUX_CODE_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/tmux ]]; then
  mv $LOCAL_BIN_DIR_PATH/{tmux,tmux.prev}
fi

UTF8PROC_PATH=$HOMEBREW_INSTALL_DIR_PATH/opt/utf8proc

./autogen.sh
./configure                         \
  --prefix=$LOCAL_DIR_PATH          \
  --enable-utf8proc                 \
  CFLAGS="-I$UTF8PROC_PATH/include" \
  LDFLAGS="-L$UTF8PROC_PATH/lib"
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
