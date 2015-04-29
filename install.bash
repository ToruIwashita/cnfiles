#!/usr/bin/env bash

# base dir
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
SCRIPT_DIR_PATH=$BASE_DIR_PATH/scripts

$SCRIPT_DIR_PATH/install-ctags-to-local.bash
$SCRIPT_DIR_PATH/install-luajit-to-local.bash
$SCRIPT_DIR_PATH/install-peco-to-local.bash
$SCRIPT_DIR_PATH/install-silver-searcher-to-local.bash
$SCRIPT_DIR_PATH/install-tig-to-local.bash
$SCRIPT_DIR_PATH/install-tmux-mem-cpu-load-to-local.bash
$SCRIPT_DIR_PATH/install-tmux-to-local.bash
$SCRIPT_DIR_PATH/install-vim-to-local.bash
$SCRIPT_DIR_PATH/install-zsh-to-local.bash

printf "\ncomplete\n"
exit 0
