#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# check ruby
if [[ ! $RUBY_PATH =~ anyenv ]]; then
  printf "there is no ruby installed with anyenv\n"
  exit 1
fi

# check python2
if [[ ! $PYTHON2_PATH =~ anyenv ]]; then
  printf "there is no python2 installed with anyenv\n"
  exit 1
fi

# check python3
if [[ ! $PYTHON3_PATH =~ anyenv ]]; then
  printf "there is no python3 installed with anyenv\n"
  exit 1
fi

# check luajit
if [[ ! $LUAJIT_PATH =~ anyenv ]]; then
  printf "there is no luajit installed with anyenv\n"
  exit 1
fi

cd $VIM_SRC_DIR_PATH

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/vim ]]; then
  mv $LOCAL_BIN_DIR_PATH/{vim,vim.prev}
fi

./configure \
  --prefix=$LOCAL_DIR_PATH                      \
  --with-features=huge                          \
  --enable-multibyte                            \
  --enable-xim                                  \
  --enable-fontset                              \
  --with-ruby-command=$RUBY_PATH                \
  --enable-rubyinterp=dynamic                   \
  --enable-pythoninterp=dynamic                 \
  --with-python-config-dir=$PYTHON2_CONFIG_DIR  \
  --enable-python3interp=dynamic                \
  --with-python3-config-dir=$PYTHON3_CONFIG_DIR \
  --enable-luainterp=dynamic                    \
  --with-lua-prefix=$LUAJIT_PREFIX_DIR          \
  --with-luajit                                 \
  --enable-fail-if-missing
make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
