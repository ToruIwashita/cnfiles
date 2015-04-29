#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# src dir
SRC_DIR_PATH=$BASE_DIR_PATH/modules/vim
# install dir
LOCAL_DIR_PATH=~/local
# ruby path
RUBY_PATH=${1:-$(which ruby)}

set -e

if [[ -z $RUBY_PATH ]]; then
  printf "ruby not found\n"
  exit 1
fi

if [[ $(which luajit) != $LOCAL_DIR_PATH/bin/luajit ]]; then
  printf "luajit bin is required in $LOCAL_DIR_PATH\n"
  exit 1
fi

cd $SRC_DIR_PATH

# backup
if [[ -f $LOCAL_DIR_PATH/bin/vim ]]; then
  mv $LOCAL_DIR_PATH/bin/{vim,vim.prev}
fi

./configure                         \
  --prefix=$LOCAL_DIR_PATH          \
  --with-features=huge              \
  --enable-multibyte                \
  --enable-xim                      \
  --enable-fontset                  \
  --with-ruby-command=$RUBY_PATH    \
  --enable-rubyinterp=dynamic       \
  --enable-luainterp=dynamic        \
  --with-lua-prefix=$LOCAL_DIR_PATH \
  --with-luajit
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
