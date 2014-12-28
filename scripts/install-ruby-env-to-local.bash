#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# rbenv src dir
RBENV_SRC_DIR_PATH=$BASE_DIR_PATH/modules/rbenv
# ruby-build src dir
RUBY_BUILD_SRC_DIR_PATH=$BASE_DIR_PATH/modules/ruby-build
# install dir
LOCAL_DIR_PATH=~/local

# install rbenv
cd $RBENV_SRC_DIR_PATH
ls bin/ | while read line; do
  ln -is $RBENV_SRC_DIR_PATH/bin/$line $LOCAL_DIR_PATH/bin/$line
done

# install ruby-build
cd $RUBY_BUILD_SRC_DIR_PATH
PREFIX=$LOCAL_DIR_PATH ./install.sh

printf "\ncomplete\n"
exit 0
