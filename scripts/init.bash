#!/usr/bin/env bash

## dir,path
__FILE__=$_
BASE_DIR_PATH=${__FILE__%/./*}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# src dir,path
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local

# cache
CACHE_DIR=cache
CACHE_DIR_PATH=~/.$CACHE_DIR

## create base dir
# source dir
if [[ -d $SRC_DIR_PATH ]]; then
  printf "\n$SRC_DIR_PATH dir already exists\n"
else
  printf "\nmkdir $SRC_DIR_PATH\n"
  mkdir $SRC_DIR_PATH
fi

# local dir
if [[ -d $LOCAL_DIR_PATH ]]; then
  printf "\n$LOCAL_DIR_PATH dir already exists\n"
else
  printf "\nmkdir $LOCAL_DIR_PATH\n"
  mkdir $LOCAL_DIR_PATH
fi

# cache dir
if [[ -d $CACHE_DIR_PATH ]]; then
  printf "\n$CACHE_DIR_PATH dir already exists\n"
else
  printf "\nmkdir $CACHE_DIR_PATH\n"
  mkdir $CACHE_DIR_PATH
fi

# yankring dir
if [[ -d $CACHE_DIR_PATH/yankring ]]; then
  printf "\n$CACHE_DIR_PATH/yankring dir already exists\n"
else
  printf "\nmkdir $CACHE_DIR_PATH/yankring\n"
  mkdir $CACHE_DIR_PATH/yankring
fi

## create symlink
# zsh
if [[ -L ~/.zshrc ]]; then
  printf "\n$BASE_DIR_PATH/.zshrc symlink already exists\n"
else
  printf "\ncreate symlink ~/.zshrc\n"
  ln -is  $BASE_DIR_PATH/zshrc ~/.zshrc
fi

if [[ -L ~/.zsh.d ]]; then
  printf "\n$BASE_DIR_PATH/.zsh.d dir symlink already exists\n"
else
  printf "\ncreate symlink ~/.zsh.d dir\n"
  ln -isn $BASE_DIR_PATH/zsh.d ~/.zsh.d
fi

# vim
if [[ -L ~/.vimrc ]]; then
  printf "\n$BASE_DIR_PATH/.vimrc symlink already exists\n"
else
  printf "\ncreate symlink ~/.vimrc\n"
  ln -is  $BASE_DIR_PATH/vimrc ~/.vimrc
fi

if [[ -L ~/.vim ]]; then
  printf "\n$BASE_DIR_PATH/.vim dir symlink already exists\n"
else
  printf "\ncreate symlink ~/.vim dir\n"
  ln -isn $BASE_DIR_PATH/vim   ~/.vim
fi

# tmux
if [[ -L ~/.tmux.conf ]]; then
  printf "\n$BASE_DIR_PATH/.tmux.conf symlink already exists\n"
else
  printf "\ncreate symlink ~/.tmux.conf\n"
  ln -is $BASE_DIR_PATH/tmux.conf ~/.tmux.conf
fi

# peco
if [[ -L ~/.peco ]]; then
  printf "\n$BASE_DIR_PATH/.peco dir symlink already exists\n"
else
  printf "\ncreate symlink ~/.peco dir\n"
  ln -isn $BASE_DIR_PATH/peco ~/.peco
fi

# pry
if [[ -L ~/.pryrc ]]; then
  printf "\n$BASE_DIR_PATH/.pryrc symlink already exists\n"
else
  printf "\ncreate symlink ~/.pryrc\n"
  ln -is $BASE_DIR_PATH/pryrc ~/.pryrc
fi

printf "\ncomplete\n"
exit 0
