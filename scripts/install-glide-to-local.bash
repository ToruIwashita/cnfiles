#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $GLIDE_SRC_DIR_PATH

# github.com/Mastrminds dir
if [[ -d $GLIDE_GITHUB_DIR_PATH_IN_GOPATH ]]; then
  printf "\n$GLIDE_GITHUB_DIR_PATH_IN_GOPATH dir already exists\n"
else
  printf "\nmkdir $GLIDE_GITHUB_DIR_PATH_IN_GOPATH\n"
  mkdir -p $GLIDE_GITHUB_DIR_PATH_IN_GOPATH
fi

# create glide dir symlink
if [[ -L $GLIDE_GITHUB_DIR_PATH_IN_GOPATH/glide ]]; then
  printf "\n$GLIDE_GITHUB_DIR_PATH_IN_GOPATH/glide symlink already exists\n"
else
  printf "\ncreate symlink $GLIDE_GITHUB_DIR_PATH_IN_GOPATH/glide\n"
  ln -is $GLIDE_SRC_DIR_PATH $GLIDE_GITHUB_DIR_PATH_IN_GOPATH/glide
fi

make build

printf "\ncomplete\n"
exit 0
