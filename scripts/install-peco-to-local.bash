#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $PECO_SRC_DIR_PATH

# github.com/peco dir
if [[ -d $PECO_GITHUB_DIR_PATH_IN_GOPATH ]]; then
  printf "\n$PECO_GITHUB_DIR_PATH_IN_GOPATH dir already exists\n"
else
  printf "\nmkdir $PECO_GITHUB_DIR_PATH_IN_GOPATH\n"
  mkdir -p $PECO_GITHUB_DIR_PATH_IN_GOPATH
fi

# create peco dir symlink
if [[ -L $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco ]]; then
  printf "\n$PECO_GITHUB_DIR_PATH_IN_GOPATH/peco symlink already exists\n"
else
  printf "\ncreate symlink $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco\n"
  ln -is $PECO_SRC_DIR_PATH $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco
fi

cd $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco
make installdeps
make build

if [[ -L $LOCAL_BIN_DIR_PATH/peco ]]; then
  printf "\n$LOCAL_BIN_DIR_PATH/peco symlink already exists\n"
else
  printf "\ncreate symlink $LOCAL_BIN_DIR_PATH/peco\n"
  ln -is $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco/peco $LOCAL_BIN_DIR_PATH/peco
fi

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
