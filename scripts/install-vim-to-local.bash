#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# ruby
RUBY_PATH=${1:-$(which ruby)}

# python
PYTHON2_PATH=${1:-$(which python2)}
PYTHON2_VERSION_STDOUT=$(python2 --version 2>&1)
PYTHON2_VERSION=${PYTHON2_VERSION_STDOUT#*[[:space:]]}
PYTHON2_MINOR_VERSION=${PYTHON2_VERSION%.*}
PYTHON2_CONFIG_DIR=$ANYENV_ENVS_DIR_PATH/pyenv/versions/$PYTHON2_VERSION/lib/python$PYTHON2_MINOR_VERSION/config
PYTHON3_PATH=${1:-$(which python3)}
PYTHON3_VERSION_STDOUT=$(python3 --version 2>&1)
PYTHON3_VERSION=${PYTHON3_VERSION_STDOUT#*[[:space:]]}
PYTHON3_MINOR_VERSION=${PYTHON3_VERSION%.*}
PYTHON3_CONFIG_DIR=$ANYENV_ENVS_DIR_PATH/pyenv/versions/$PYTHON3_VERSION/lib/python$PYTHON3_MINOR_VERSION/config-3.6m-$OS_INFO

# luajit
LUAJIT_PATH=${1:-$(which luajit)}
LUAJIT_PREFIX_DIR=$ANYENV_ENVS_DIR_PATH/luaenv/versions/$(luaenv version | sed -e 's/ .*$//g')

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
