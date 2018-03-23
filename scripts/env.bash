#!/usr/bin/env bash

__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# OS info
OS_INFO=darwin

# local dir
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local
LOCAL_BIN_DIR_PATH=$LOCAL_DIR_PATH/bin
LOCAL_LIB_DIR_PATH=$LOCAL_DIR_PATH/lib
LOCAL_INCLUDE_DIR_PATH=$LOCAL_DIR_PATH/include
SUBMODULES_DIR_PATH=$BASE_DIR_PATH/modules

# cache
CACHE_DIR_PATH=~/.cache

# works
WORKS_DIR_PATH=~/works
TMP_DIR_PATH=$WORKS_DIR_PATH/tmp

# memolist
MEMOLIST_DIR_PATH=~/.memolist

# submodules src dir
CTAGS_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/ctags
GIT_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/git
GRAPHVIZ_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/graphviz
LUAJIT_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/LuaJIT
NODE_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/node
HUB_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/hub
JQ_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/jq
PECO_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/peco
ANYENV_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/anyenv
GO_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/go
THE_SILVER_SEARCHER_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/the_silver_searcher
TMUX_CODE_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/tmux
TMUX_MEM_CPU_LOAD_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/tmux-mem-cpu-load
VIM_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/vim
NEOVIM_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/neovim
ZSH_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/zsh

# zsh
ZSH_DIR_PATH=$BASE_DIR_PATH/zsh.d
ZSH_CONFIG_LOCAL_FILE_SOURCE_PATH=$BASE_DIR_PATH/zsh.local.d/config.local.zsh
ZSH_ENV_LOCAL_FILE_SOURCE_PATH=$BASE_DIR_PATH/zsh.local.d/env.local.zsh
ZSH_CONFIG_LOCAL_DIR_SOURCE_PATH=$BASE_DIR_PATH/zsh.local.d/local
ZSH_CONFIG_LOCAL_FILE_DEST_PATH=$BASE_DIR_PATH/zsh.d/config.local.zsh
ZSH_ENV_LOCAL_FILE_DEST_PATH=$BASE_DIR_PATH/zsh.d/env.local.zsh
ZSH_CONFIG_LOCAL_DIR_DEST_PATH=$BASE_DIR_PATH/zsh.d/local

# git
GIT_DIR_PATH=$BASE_DIR_PATH/git

# ruby
RUBY_PATH=${1:-$(which ruby)}

# python
PYTHON_VERSION_STDOUT=$(python --version 2>&1)
PYTHON_VERSION=${PYTHON_VERSION_STDOUT#*[[:space:]]}
PYTHON_MINOR_VERSION=${PYTHON_VERSION%.*}
PYTHON_CONFIG_DIR=~/.anyenv/envs/pyenv/versions/$PYTHON_VERSION/lib/python$PYTHON_MINOR_VERSION/config
PYTHON3_VERSION_STDOUT=$(python3 --version 2>&1)
PYTHON3_VERSION=${PYTHON3_VERSION_STDOUT#*[[:space:]]}
PYTHON3_MINOR_VERSION=${PYTHON3_VERSION%.*}
PYTHON3_CONFIG_DIR=~/.anyenv/envs/pyenv/versions/$PYTHON3_VERSION/lib/python$PYTHON3_MINOR_VERSION/config-3.6m-$OS_INFO

# scala
SBT_DIR=~/.sbt/$(sbtenv version | sed -e 's/^sbt-\([0-9]*.[0-9]*\).*/\1/g')

# go
GOROOT=$LOCAL_DIR_PATH/go
GOPATH=~/.go
# go1.4
GOROOT_1_4=$LOCAL_DIR_PATH/go1.4

# go path
HUB_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/github
PECO_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/peco

# node
NPM_HOME=~/.npm

# memolist tmp file
MEMOLIST_TMP_MARKDOWN_FILE=$MEMOLIST_DIR_PATH/0000-00-00-tmp.md
MEMOLIST_TMP_FILE=$MEMOLIST_DIR_PATH/0000-00-00-tmp.txt
