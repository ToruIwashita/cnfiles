#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# peco src dir
PECO_SRC_DIR_PATH=$BASE_DIR_PATH/modules/peco
# create bin symlink dir
LOCAL_BIN_DIR_PATH=~/local/bin
# go path
PECO_GITHUB_DIR_PATH_IN_GOPATH=~/.go/src/github.com/peco

set -e

cd $PECO_SRC_DIR_PATH

go get github.com/jessevdk/go-flags
go get github.com/mattn/go-runewidth
go get github.com/nsf/termbox-go

# github.com/peco dir
if [[ -d $PECO_GITHUB_DIR_PATH_IN_GOPATH ]]; then
  printf "\n$PECO_GITHUB_DIR_PATH_IN_GOPATH dir already exists\n"
else
  printf "\nmkdir $PECO_GITHUB_DIR_PATH_IN_GOPATH\n"
  mkdir $PECO_GITHUB_DIR_PATH_IN_GOPATH
fi

# create peco dir symlink 
if [[ -L $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco ]]; then
  printf "\n$PECO_GITHUB_DIR_PATH_IN_GOPATH/peco symlink already exists\n"
else
  printf "\ncreate symlink $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco\n"
  ln -is $PECO_SRC_DIR_PATH $PECO_GITHUB_DIR_PATH_IN_GOPATH/peco
fi

go build ./cmd/peco/peco.go

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
