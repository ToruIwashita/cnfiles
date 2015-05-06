#!/usr/bin/env bash

# base dir
source $(cd $(dirname $_);pwd)/env.bash
set -e

cd $GIT_SRC_DIR_PATH

ln -is $GIT_SRC_DIR_PATH/contrib/diff-highlight/diff-highlight $LOCAL_BIN_DIR_PATH/git-diff-highlight

printf "\ncomplete\n"
exit 0
