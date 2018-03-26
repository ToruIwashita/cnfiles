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

# peco in go path
PECO_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/peco

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

# backup
if [[ -f peco ]]; then
  mv {peco,peco.prev}
fi

glide install
go build cmd/peco/peco.go

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
