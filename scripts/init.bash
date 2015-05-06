#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

# src dir,path
ZSH_CONFIG_LOCAL_FILE_SOURCE_PATH=$BASE_DIR_PATH/zsh.local.d/config.local.zsh
ZSH_CONFIG_LOCAL_DIR_SOURCE_PATH=$BASE_DIR_PATH/zsh.local.d/local
ZSH_CONFIG_LOCAL_FILE_DEST_PATH=$BASE_DIR_PATH/zsh.d/config.local.zsh
ZSH_CONFIG_LOCAL_DIR_DEST_PATH=$BASE_DIR_PATH/zsh.d/local

$(cd $BASE_DIR_PATH;git submodule update --init)

## create base dir
# source dir
if [[ -d $SRC_DIR_PATH ]]; then
  printf "\e[32m$SRC_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $SRC_DIR_PATH\e[0m\n"
  mkdir $SRC_DIR_PATH
fi

# local dir
if [[ -d $LOCAL_DIR_PATH ]]; then
  printf "\e[32m$LOCAL_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $LOCAL_DIR_PATH\e[0m\n"
  mkdir $LOCAL_DIR_PATH
fi

# local bin dir
if [[ -d $LOCAL_BIN_DIR_PATH ]]; then
  printf "\e[32m$LOCAL_BIN_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $LOCAL_BIN_DIR_PATH\e[0m\n"
  mkdir $LOCAL_BIN_DIR_PATH
fi

# zsh.d/config.local.zsh file
if [[ -f $ZSH_CONFIG_LOCAL_FILE_DEST_PATH ]]; then
  printf "\e[32m$ZSH_CONFIG_LOCAL_FILE_DEST_PATH file already exists\e[0m\n"
else
  printf "\e[31mcopy file $ZSH_CONFIG_LOCAL_FILE_SOURCE_PATH to $ZSH_CONFIG_LOCAL_FILE_DEST_PATH\e[0m\n"
  cp -p $ZSH_CONFIG_LOCAL_FILE_SOURCE_PATH $ZSH_CONFIG_LOCAL_FILE_DEST_PATH
fi

# zsh.d/local dir
if [[ -d $ZSH_CONFIG_LOCAL_DIR_DEST_PATH ]]; then
  printf "\e[32m$ZSH_CONFIG_LOCAL_DIR_DEST_PATH dir already exists\e[0m\n"
else
  printf "\e[31mcopy dir $ZSH_CONFIG_LOCAL_DIR_SOURCE_PATH to $ZSH_CONFIG_LOCAL_DIR_DEST_PATH\e[0m\n"
  cp -rp $ZSH_CONFIG_LOCAL_DIR_SOURCE_PATH $ZSH_CONFIG_LOCAL_DIR_DEST_PATH
fi

# cache dir
if [[ -d $CACHE_DIR_PATH ]]; then
  printf "\e[32m$CACHE_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $CACHE_DIR_PATH\e[0m\n"
  mkdir $CACHE_DIR_PATH
fi

# yankring dir
if [[ -d $CACHE_DIR_PATH/yankring ]]; then
  printf "\e[32m$CACHE_DIR_PATH/yankring dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $CACHE_DIR_PATH/yankring\e[0m\n"
  mkdir $CACHE_DIR_PATH/yankring
fi

## create symlink
# zsh
if [[ -L ~/.zshrc ]]; then
  printf "\e[32m$BASE_DIR_PATH/.zshrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.zshrc\e[0m\n"
  ln -is  $BASE_DIR_PATH/zshrc ~/.zshrc
fi

if [[ -L ~/.zsh.d ]]; then
  printf "\e[32m$BASE_DIR_PATH/.zsh.d dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.zsh.d dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/zsh.d ~/.zsh.d
fi

# vim
if [[ -L ~/.vimrc ]]; then
  printf "\e[32m$BASE_DIR_PATH/.vimrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.vimrc\e[0m\n"
  ln -is  $BASE_DIR_PATH/vimrc ~/.vimrc
fi

if [[ -L ~/.vim ]]; then
  printf "\e[32m$BASE_DIR_PATH/.vim dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.vim dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/vim   ~/.vim
fi

# tmux
if [[ -L ~/.tmux.conf ]]; then
  printf "\e[32m$BASE_DIR_PATH/.tmux.conf symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.tmux.conf\e[0m\n"
  ln -is $BASE_DIR_PATH/tmux.conf ~/.tmux.conf
fi

if [[ -L ~/.tmux ]]; then
  printf "\e[32m$BASE_DIR_PATH/.tmux dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.tmux dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/tmux   ~/.tmux
fi

# peco
if [[ -L ~/.peco ]]; then
  printf "\e[32m$BASE_DIR_PATH/.peco dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.peco dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/peco ~/.peco
fi

# pry
if [[ -L ~/.pryrc ]]; then
  printf "\e[32m$BASE_DIR_PATH/.pryrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.pryrc\e[0m\n"
  ln -is $BASE_DIR_PATH/pryrc ~/.pryrc
fi

# awesome_print
if [[ -L ~/.aprc ]]; then
  printf "\e[32m$BASE_DIR_PATH/.aprc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.aprc\e[0m\n"
  ln -is $BASE_DIR_PATH/aprc ~/.aprc
fi

printf "\ninit complete\n"
exit 0
