#!/usr/bin/env bash

## dir,path
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts}

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
if [[ ! -L ~/.zshrc ]]; then
  printf "\n### create symlink for zshrc\n"
  ln -is  $BASE_DIR_PATH/zshrc ~/.zshrc
fi
if [[ ! -L ~/.zsh.d ]]; then
  printf "\n### create symlink for zsh.d dir\n"
  ln -isn $BASE_DIR_PATH/zsh.d ~/.zsh.d
fi

# vim
if [[ ! -L ~/.vimrc ]]; then
  printf "\n### create symlink for vimrc\n"
  ln -is  $BASE_DIR_PATH/vimrc ~/.vimrc
fi
if [[ ! -L ~/.vim ]]; then
  printf "\n### create symlink for vim dir\n"
  ln -isn $BASE_DIR_PATH/vim   ~/.vim
fi

# tmux
if [[ ! -L ~/.tmux.conf ]]; then
  printf "\n### create symlink for tmux.config\n"
  ln -is $BASE_DIR_PATH/tmux.conf ~/.tmux.conf
fi

# peco
if [[ ! -L ~/.peco ]]; then
  printf "\n### create symlink for peco dir\n"
  ln -isn $BASE_DIR_PATH/peco ~/.peco
fi

# pry
if [[ ! -L ~/.pryrc ]]; then
  printf "\n### create symlink for pryrc\n"
  ln -is $BASE_DIR_PATH/pryrc ~/.pryrc
fi

printf "\ncomplete\n"
exit 0
