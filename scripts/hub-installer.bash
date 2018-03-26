#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which go)} =~ anyenv ]]; then
  printf "there is no go installed with anyenv\n"
  exit 1
fi

export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

# create $GOPATH
if [[ -d $GOPATH ]]; then
  printf "\e[32m$GOPATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $GOPATH\e[0m\n"
  mkdir $GOPATH
fi

# create $GOPATH/bin
if [[ -d $GOPATH/bin ]]; then
  printf "\e[32m$GOPATH/bin dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $GOPATH/bin\e[0m\n"
  mkdir $GOPATH/bin
fi

export PATH="$PATH:$GOPATH/bin"

# github in go path
HUB_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/github

cd $HUB_SRC_DIR_PATH

# create github.com/hub dir
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
