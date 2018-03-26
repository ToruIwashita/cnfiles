#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

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

# works dir
if [[ -d $WORKS_DIR_PATH ]]; then
  printf "\e[32m$WORKS_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $WORKS_DIR_PATH\e[0m\n"
  mkdir $WORKS_DIR_PATH
fi

# tmp dir
if [[ -d $TMP_DIR_PATH ]]; then
  printf "\e[32m$TMP_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $TMP_DIR_PATH\e[0m\n"
  mkdir $TMP_DIR_PATH
fi

# zsh.d/local dir
if [[ -d $BASE_DIR_PATH/zsh.d/local ]]; then
  printf "\e[32m$BASE_DIR_PATH/zsh.d/local dir already exists\e[0m\n"
else
  printf "\e[31mcopy dir $BASE_DIR_PATH/zsh.local.d/local to $BASE_DIR_PATH/zsh.d/local\e[0m\n"
  cp -rp $BASE_DIR_PATH/zsh.local.d/local $BASE_DIR_PATH/zsh.d
fi

# cache dir
if [[ -d $CACHE_DIR_PATH ]]; then
  printf "\e[32m$CACHE_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $CACHE_DIR_PATH\e[0m\n"
  mkdir $CACHE_DIR_PATH
fi

# memolist dir
if [[ -d $MEMOLIST_DIR_PATH ]]; then
  printf "\e[32m$MEMOLIST_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $MEMOLIST_DIR_PATH\e[0m\n"
  mkdir $MEMOLIST_DIR_PATH
fi

## copy zsh config file
# zsh.d/config.local.zsh file
if [[ -f $BASE_DIR_PATH/zsh.d/config.local.zsh ]]; then
  printf "\e[32m$BASE_DIR_PATH/zsh.d/config.local.zsh file already exists\e[0m\n"
else
  printf "\e[31mcopy file $BASE_DIR_PATH/zsh.local.d/config.local.zsh to $BASE_DIR_PATH/zsh.d/config.local.zsh\e[0m\n"
  cp -p $BASE_DIR_PATH/zsh.local.d/config.local.zsh $BASE_DIR_PATH/zsh.d/config.local.zsh
fi

# zsh.d/env.local.zsh file
if [[ -f $BASE_DIR_PATH/zsh.d/env.local.zsh ]]; then
  printf "\e[32m$BASE_DIR_PATH/zsh.d/env.local.zsh file already exists\e[0m\n"
else
  printf "\e[31mcopy file $BASE_DIR_PATH/zsh.local.d/env.local.zsh to $BASE_DIR_PATH/zsh.d/env.local.zsh\e[0m\n"
  cp -p $BASE_DIR_PATH/zsh.local.d/env.local.zsh $BASE_DIR_PATH/zsh.d/env.local.zsh
fi

## create symlink
# zsh
if [[ -L ~/.zshrc ]]; then
  printf "\e[32m~/.zshrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.zshrc\e[0m\n"
  ln -is $BASE_DIR_PATH/zshrc ~/.zshrc
fi

if [[ -L ~/.zsh.d ]]; then
  printf "\e[32m~/.zsh.d dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.zsh.d dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/zsh.d ~/.zsh.d
fi

# vim
if [[ -L ~/.vimrc ]]; then
  printf "\e[32m~/.vimrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.vimrc\e[0m\n"
  ln -is $BASE_DIR_PATH/vimrc ~/.vimrc
fi

if [[ -L ~/.vim ]]; then
  printf "\e[32m~/.vim dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.vim dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/vim ~/.vim
fi

# tmux
if [[ -L ~/.tmux.conf ]]; then
  printf "\e[32m~/.tmux.conf symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.tmux.conf\e[0m\n"
  ln -is $BASE_DIR_PATH/tmux.conf ~/.tmux.conf
fi

if [[ -L ~/.tmux ]]; then
  printf "\e[32m~/.tmux dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.tmux dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/tmux   ~/.tmux
fi

# peco
if [[ -L ~/.peco ]]; then
  printf "\e[32m~/.peco dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.peco dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/peco ~/.peco
fi

# ctags
if [[ -L ~/.ctags.d ]]; then
  printf "\e[32m~/.ctags.d dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.ctags.d dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/ctags.d ~/.ctags.d
fi

# lint
if [[ -L ~/.lint ]]; then
  printf "\e[32m~/.lint symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.lint dir\e[0m\n"
  ln -is $BASE_DIR_PATH/lint ~/.lint
fi

# gitconfig
if [[ -L ~/.gitconfig ]]; then
  printf "\e[32m~/.gitconfig symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.gitconfig\e[0m\n"
  ln -is $GIT_DIR_PATH/gitconfig ~/.gitconfig
fi

# gitattributes
if [[ -L ~/.gitattributes ]]; then
  printf "\e[32m~/.gitattributes symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.gitattributes\e[0m\n"
  ln -is $GIT_DIR_PATH/gitattributes ~/.gitattributes
fi

# gitignore
if [[ -L ~/.gitignore ]]; then
  printf "\e[32m~/.gitignore  symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.gitignore \e[0m\n"
  ln -is $GIT_DIR_PATH/gitignore  ~/.gitignore
fi

# pry
if [[ -L ~/.pryrc ]]; then
  printf "\e[32m~/.pryrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.pryrc\e[0m\n"
  ln -is $BASE_DIR_PATH/pryrc ~/.pryrc
fi

# rspec
if [[ -L ~/.rspec ]]; then
  printf "\e[32m~/.rspec symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.rspec\e[0m\n"
  ln -is $BASE_DIR_PATH/rspec ~/.rspec
fi

# awesome_print
if [[ -L ~/.aprc ]]; then
  printf "\e[32m~/.aprc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.aprc\e[0m\n"
  ln -is $BASE_DIR_PATH/aprc ~/.aprc
fi

# sbtrc
if [[ -L ~/.sbtrc ]]; then
  printf "\e[32m~/.sbtrc symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.sbtrc\e[0m\n"
  ln -is $BASE_DIR_PATH/sbtrc ~/.sbtrc
fi

## create initial file
# memolist tmp markdown file
if [[ -f $MEMOLIST_TMP_MARKDOWN_FILE ]]; then
  printf "\e[32m$MEMOLIST_TMP_MARKDOWN_FILE file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_MARKDOWN_FILE\e[0m\n"
  touch $MEMOLIST_TMP_MARKDOWN_FILE
fi

# memolist tmp file
if [[ -f $MEMOLIST_TMP_FILE ]]; then
  printf "\e[32m$MEMOLIST_TMP_FILE file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_FILE\e[0m\n"
  touch $MEMOLIST_TMP_FILE
fi

printf "\ninit complete\n"
exit 0
