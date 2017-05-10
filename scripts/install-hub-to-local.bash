#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $HUB_SRC_DIR_PATH

# github.com/hub dir
if [[ -d $HUB_GITHUB_DIR_PATH_IN_GOPATH ]]; then
  printf "\n$HUB_GITHUB_DIR_PATH_IN_GOPATH dir already exists\n"
else
  printf "\nmkdir $HUB_GITHUB_DIR_PATH_IN_GOPATH\n"
  mkdir -p $HUB_GITHUB_DIR_PATH_IN_GOPATH
fi

# create hub dir symlink
if [[ -L $HUB_GITHUB_DIR_PATH_IN_GOPATH/hub ]]; then
  printf "\n$HUB_GITHUB_DIR_PATH_IN_GOPATH/hub symlink already exists\n"
else
  printf "\ncreate symlink $HUB_GITHUB_DIR_PATH_IN_GOPATH/hub\n"
  ln -is $HUB_SRC_DIR_PATH $HUB_GITHUB_DIR_PATH_IN_GOPATH/hub
fi

./script/build

if [[ -L $LOCAL_BIN_DIR_PATH/hub ]]; then
  printf "\n$LOCAL_BIN_DIR_PATH/hub symlink already exists\n"
else
  printf "\ncreate symlink $LOCAL_BIN_DIR_PATH/hub\n"
  ln -is $HUB_GITHUB_DIR_PATH_IN_GOPATH/hub/bin/hub $LOCAL_BIN_DIR_PATH/hub
fi

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
