#!/usr/bin/env bash

## dir,path
__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# src dir,path
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local
LOCAL_BIN_DIR_PATH=$LOCAL_DIR_PATH/bin
CNBUNDLE_DIR_PATH=~/.cnbundle
ZSH_CONFIG_LOCAL_FILE_SOUCE_PATH=$BASE_DIR_PATH/zsh.local.d/config.local.zsh
ZSH_CONFIG_LOCAL_DIR_SOUCE_PATH=$BASE_DIR_PATH/zsh.local.d/local
ZSH_CONFIG_LOCAL_FILE_DEST_PATH=$BASE_DIR_PATH/zsh.d/config.local.zsh
ZSH_CONFIG_LOCAL_DIR_DEST_PATH=$BASE_DIR_PATH/zsh.d/local

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

# local bin dir
if [[ -d $LOCAL_BIN_DIR_PATH ]]; then
  printf "\n$LOCAL_BIN_DIR_PATH dir already exists\n"
else
  printf "\nmkdir $LOCAL_BIN_DIR_PATH\n"
  mkdir $LOCAL_BIN_DIR_PATH
fi

# zsh.d/config.local.zsh file
if [[ -f $ZSH_CONFIG_LOCAL_FILE_DEST_PATH ]]; then
  printf "\n$ZSH_CONFIG_LOCAL_FILE_DEST_PATH file already exists\n"
else
  printf "\ncopy file $ZSH_CONFIG_LOCAL_FILE_SOUCE_PATH to $ZSH_CONFIG_LOCAL_FILE_DEST_PATH\n"
  cp -p $ZSH_CONFIG_LOCAL_FILE_SOUCE_PATH $ZSH_CONFIG_LOCAL_FILE_DEST_PATH
fi

# zsh.d/local dir
if [[ -d $ZSH_CONFIG_LOCAL_DIR_DEST_PATH ]]; then
  printf "\n$ZSH_CONFIG_LOCAL_DIR_DEST_PATH dir already exists\n"
else
  printf "\ncopy dir $ZSH_CONFIG_LOCAL_DIR_SOURCE_PATH to $ZSH_CONFIG_LOCAL_DIR_DEST_PATH\n"
  cp -rp $ZSH_CONFIG_LOCAL_DIR_SOURCE_PATH $ZSH_CONFIG_LOCAL_DIR_DEST_PATH
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

# cnbundle dir
if [[ -d $CNBUNDLE_DIR_PATH ]]; then
  printf "\n$CNBUNDLE_DIR_PATH dir already exists\n"
else
  printf "\nmkdir $CNBUNDLE_DIR_PATH\n"
  mkdir $CNBUNDLE_DIR_PATH
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
