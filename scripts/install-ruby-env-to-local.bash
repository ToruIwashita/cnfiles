#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $RBENV_SRC_DIR_PATH
ls bin/ | while read line; do
  if [[ ! -L $LOCAL_BIN_DIR_PATH/$line ]]; then
    ln -is $RBENV_SRC_DIR_PATH/bin/$line $LOCAL_BIN_DIR_PATH/$line
  fi
done

# install ruby-build
cd $RUBY_BUILD_SRC_DIR_PATH
PREFIX=$LOCAL_DIR_PATH ./install.sh

printf "\ncomplete\n"
exit 0
