#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# asdf
ASDF_DIR_PATH=~/.asdf
ASDF_ENVS_DIR_PATH=$ASDF_DIR_PATH/installs

# ruby
RUBY_PATH=${1:-$(which ruby)}
RUBY_VERSION_STDOUT=$(ruby -v 2>&1)
PREFIX_REMOVED_RUBY_VERSION_STDOUT=${RUBY_VERSION_STDOUT#*[[:space:]]}
RUBY_VERSION=${PREFIX_REMOVED_RUBY_VERSION_STDOUT%%p*}
RUBY_LIB_DIR=$ASDF_ENVS_DIR_PATH/ruby/$RUBY_VERSION/lib

# python
PYTHON2_PATH=${1:-$(which python2)}
PYTHON2_VERSION_STDOUT=$(python2 --version 2>&1)
PYTHON2_VERSION=${PYTHON2_VERSION_STDOUT#*[[:space:]]}
PYTHON2_LIB_DIR=$ASDF_ENVS_DIR_PATH/python/$PYTHON2_VERSION/lib
PYTHON3_PATH=${1:-$(which python3)}
PYTHON3_VERSION_STDOUT=$(python3 --version 2>&1)
PYTHON3_VERSION=${PYTHON3_VERSION_STDOUT#*[[:space:]]}
PYTHON3_LIB_DIR=$ASDF_ENVS_DIR_PATH/python/$PYTHON3_VERSION/lib

# check ruby
if [[ ! $RUBY_PATH =~ asdf ]]; then
  printf "there is no ruby installed with asdf\n"
  exit 1
fi

# check python2
if [[ ! $PYTHON2_PATH =~ asdf ]]; then
  printf "there is no python2 installed with asdf\n"
  exit 1
fi

# check python3
if [[ ! $PYTHON3_PATH =~ asdf ]]; then
  printf "there is no python3 installed with asdf\n"
  exit 1
fi

cd $VIM_SRC_DIR_PATH

if [[ -f $VIM_SRC_DIR_PATH/src/auto/config.cache ]]; then
  rm -f src/auto/config.cache
fi

# backup
if [[ -f $LOCAL_BIN_DIR_PATH/vim ]]; then
  mv $LOCAL_BIN_DIR_PATH/{vim,vim.prev}
fi

./configure \
  --prefix=$LOCAL_DIR_PATH       \
  --with-features=huge           \
  --enable-multibyte             \
  --enable-xim                   \
  --enable-fontset               \
  --enable-rubyinterp=dynamic    \
  --enable-pythoninterp=dynamic  \
  --enable-python3interp=dynamic \
  --enable-fail-if-missing       \
  LDFLAGS=-Wl,-rpath,$RUBY_LIB_DIR,-rpath,$PYTHON3_LIB_DIR,-rpath,$PYTHON2_LIB_DIR

make && make install

git checkout .
git clean -f -d

printf "\ncomplete\n"
exit 0
