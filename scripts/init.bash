#!/usr/bin/env bash

## dir,path
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}

# src dir,path
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local

# cache
CACHE_DIR=cache
CACHE_DIR_PATH=~/.$CACHE_DIR

## init
# source,local
[[ -d $SRC_DIR_PATH ]]            || mkdir $SRC_DIR_PATH
[[ -d $LOCAL_DIR_PATH ]]          || mkdir $LOCAL_DIR_PATH
# cache dir
[[ -d $CACHE_DIR_PATH ]]          || mkdir $CACHE_DIR_PATH
[[ -d $CACHE_DIR_PATH/yankring ]] || mkdir $CACHE_DIR_PATH/yankring

## create symlink
# zsh
printf "\n### create symlink for zsh configs.\n"
ln -sf  $BASE_DIR_PATH/zshrc ~/.zshrc
ln -sfn $BASE_DIR_PATH/zsh.d ~/.zsh.d
# vim
printf "\n### create symlink for vim config.\n"
ln -sf  $BASE_DIR_PATH/vimrc ~/.vimrc
ln -sfn $BASE_DIR_PATH/vim   ~/.vim
# tmux
printf "\n### create symlink for tmux config.\n"
ln -sf $BASE_DIR_PATH/tmux.conf ~/.tmux.conf
# peco
printf "\n### create symlink for peco config.\n"
ln -sfn $BASE_DIR_PATH/peco ~/.peco
# pry
printf "\n### create symlink for pry config.\n"
ln -sf $BASE_DIR_PATH/pryrc ~/.pryrc
# go
printf "\n### create symlink for go.\n"
ln -sfn $SRC_DIR_PATH/go $LOCAL_DIR_PATH/go

printf "\ninit complete.\n"
exit 0
