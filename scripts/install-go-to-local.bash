#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

cd $GO_SRC_DIR_PATH/src

# 2016/5月現在、./all.bashはgo1.4の実行環境が入っていないと動かない
# 以下のページなどでgo1.4のバイナリを落とし~/go1.4/bin/goに配置する必要ある
# https://golang.org/dl/
./all.bash

# create peco dir symlink 
if [[ -L $LOCAL_DIR_PATH/go ]]; then
  printf "\n$LOCAL_DIR_PATH/go symlink already exists\n"
else
  printf "\ncreate symlink $LOCAL_DIR_PATH/go\n"
  ln -is $GO_SRC_DIR_PATH $LOCAL_DIR_PATH/go
fi

printf "\ncomplete\n"
exit 0
