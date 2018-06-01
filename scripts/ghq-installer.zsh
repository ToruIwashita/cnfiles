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

# ghq in go path
GHQ_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/motemen

cd $GHQ_SRC_DIR_PATH

# github.com/motemen dir
if [[ -d $GHQ_GITHUB_DIR_PATH_IN_GOPATH ]]; then
  printf "\n$GHQ_GITHUB_DIR_PATH_IN_GOPATH dir already exists\n"
else
  printf "\nmkdir $GHQ_GITHUB_DIR_PATH_IN_GOPATH\n"
  mkdir -p $GHQ_GITHUB_DIR_PATH_IN_GOPATH
fi

# create ghq dir symlink
if [[ -L $GHQ_GITHUB_DIR_PATH_IN_GOPATH/ghq ]]; then
  printf "\n$GHQ_GITHUB_DIR_PATH_IN_GOPATH/ghq symlink already exists\n"
else
  printf "\ncreate symlink $GHQ_GITHUB_DIR_PATH_IN_GOPATH/ghq\n"
  ln -is $GHQ_SRC_DIR_PATH $GHQ_GITHUB_DIR_PATH_IN_GOPATH/ghq
fi

cd $GHQ_GITHUB_DIR_PATH_IN_GOPATH/ghq

make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
