#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

INSTALL_TARGET_BRANCH=release-branch.go1.8

# ./all.bash は go1.4 がないと動かない
# go1.4 のバイナリを配置し, GOROOT_BOOTSTRAP を設定する必要がある
if [[ -x $GOROOT_1_4/bin/go ]]; then
  printf "\n$GOROOT_1_4/bin/go already exists\n"
else
  printf "\ngit clone go1.4 branch\n"
  git clone -b release-branch.go1.4 git@github.com:golang/go.git $GOROOT_1_4

  printf "\ninstall go1.4\n"
  cd $GOROOT_1_4/src
  ./make.bash
fi

# install go latest
if [[ -d $GOROOT ]]; then
  printf "\nremove $GOROOT\n"
  rm -rf $GOROOT
fi
git clone -b $INSTALL_TARGET_BRANCH git@github.com:golang/go.git $GOROOT

cd $GOROOT/src
GOROOT_BOOTSTRAP=$GOROOT_1_4 ./all.bash

printf "\ncomplete\n"
exit 0
