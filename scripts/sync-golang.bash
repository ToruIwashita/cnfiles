#!/usr/bin/env bash

# src dir,path
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local
GO_REPOSITORY='https://code.google.com/p/go'
GOROOT=$SRC_DIR_PATH/go
GOPATH=~/.go

if [[ ! -d $GOROOT ]]; then
  printf "\nclone '$GO_REPOSITORY' to $GOROOT\n"
  hg clone -u release $GO_REPOSITORY $GOROOT
fi

if [[ ! -d $GOPATH ]]; then
  printf "\nmkdir $GOPATH\n"
  mkdir -p $GOPATH
fi

printf "\nhg pull go src\n"
(cd $GOROOT && hg pull)

if [[ ! -L $LOCAL_DIR_PATH/go ]]; then
  printf "\ncreate symlink for go\n"
  ln -ins $SRC_DIR_PATH/go $LOCAL_DIR_PATH/go
fi

printf "\ncomplete\n"
exit 0
