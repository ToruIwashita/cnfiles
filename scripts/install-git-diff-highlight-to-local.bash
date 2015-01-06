#!/usr/bin/env bash

set -e

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# git src dir
GIT_SRC_DIR_PATH=$BASE_DIR_PATH/modules/git
# install dir
LOCAL_BIN_DIR_PATH=~/local/bin

cd $GIT_SRC_DIR_PATH

ln -is $GIT_SRC_DIR_PATH/contrib/diff-highlight/diff-highlight $LOCAL_BIN_DIR_PATH/git-diff-highlight

printf "\ncomplete\n"
exit 0
