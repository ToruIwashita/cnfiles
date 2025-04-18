#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# 初回インストール時はhomebrew等でgoをインストールして利用する
if ( ! $(type -a go >/dev/null 2>&1) ); then
  printf "requires go to install\n"
  exit 1
fi

cd $ASDF_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/asdf ]]; then
  mv $LOCAL_BIN_DIR_PATH/{asdf,asdf.prev}
fi

make

mv $ASDF_SRC_DIR_PATH/asdf $LOCAL_BIN_DIR_PATH/.

printf "\ncomplete\n"
exit 0
