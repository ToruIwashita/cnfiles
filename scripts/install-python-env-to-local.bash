#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $PYENV_SRC_DIR_PATH
ls bin/ | while read line; do
  if [[ ! -L $LOCAL_BIN_DIR_PATH/$line ]]; then
    ln -is $PYENV_SRC_DIR_PATH/bin/$line $LOCAL_BIN_DIR_PATH/$line
  fi
done

printf "complete\n"
exit 0
