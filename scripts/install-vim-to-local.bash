#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

# check ruby
if [[ -z $RUBY_PATH ]]; then
  printf "ruby not found\n"
  exit 1
fi

# check luajit
if [[ $(which luajit) != $LOCAL_BIN_DIR_PATH/luajit ]]; then
  printf "luajit bin is required in $LOCAL_BIN_DIR_PATH\n"
  exit 1
fi

cd $VIM_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/vim ]]; then
  mv $LOCAL_BIN_DIR_PATH/{vim,vim.prev}
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
