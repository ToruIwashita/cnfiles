#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ -d $GOROOT ]]; then
  printf "\n$GOROOT dir already exists\n"
else
  printf "\nclone '$GO_REPOSITORY' to $GOROOT\n"
  hg clone -u release $GO_REPOSITORY $GOROOT
fi

if [[ -d $GOPATH ]]; then
  printf "\n$GOPATH dir already exists\n"
else
  printf "\nmkdir $GOPATH\n"
  mkdir -p $GOPATH
fi

printf "\nhg pull go src\n"
(cd $GOROOT && hg pull && hg update release)

if [[ -L $LOCAL_DIR_PATH/go ]]; then
  printf "\n$LOCAL_DIR_PATH/go dir symlink already exists\n"
else
  printf "\ncreate symlink for go\n"
  ln -ins $SRC_DIR_PATH/go $LOCAL_DIR_PATH/go
fi

printf "\ncomplete\n"
exit 0
