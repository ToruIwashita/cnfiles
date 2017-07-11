#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# 2016/5月現在、./all.bashはgo1.4の実行環境が入っていないと動かない
# go1.4のバイナリを~/go1.4/bin/goに配置する必要ある
if [[ -d $GOPATH_1_4 ]]; then
  printf "\n$GOPATH_1_4 dir already exists\n"
else
  printf "\ngit clone go1.4 branch\n"
  git clone -b release-branch.go1.4 git@github.com:golang/go.git $GOPATH_1_4
fi

# install go 1.4
cd $GOPATH_1_4/src
./make.bash

# install go latest
cd $GO_SRC_DIR_PATH/src
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
