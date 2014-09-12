#!/usr/bin/env bash

# src dir,path
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local
GO_SRC_DIR_PATH=$SRC_DIR_PATH/go
GO_REPOSITORY='https://code.google.com/p/go' # hg repositories
GOPATH=~/.go                                 # golang

if [[ -d $GO_SRC_DIR_PATH ]]; then
  printf "clone '$GO_REPOSITORY' to $GO_SRC_DIR_PATH\n"
  hg clone -u release $GO_REPOSITORY $GO_SRC_DIR_PATH
fi

if [[ -d $GOPATH ]]; then
  printf "mkdir $GOPATH\n"
  mkdir -p $GOPATH
fi

printf "\nhg pull go src.\n"
(cd $GO_SRC_DIR_PATH && hg pull)
