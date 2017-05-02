#!/usr/bin/env bash

__FILE__=$_
BASE_DIR_PATH=${${(%):-%N}:A:h}
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# local dir
SRC_DIR_PATH=~/src
LOCAL_DIR_PATH=~/local
LOCAL_BIN_DIR_PATH=$LOCAL_DIR_PATH/bin
LOCAL_LIB_DIR_PATH=$LOCAL_DIR_PATH/lib
LOCAL_INCLUDE_DIR_PATH=$LOCAL_DIR_PATH/include
SUBMODULES_DIR_PATH=$BASE_DIR_PATH/modules

# cache
CACHE_DIR_PATH=~/.cache

# memolist
MEMOLIST_DIR_PATH=~/.memolist

# submodules src dir
CTAGS_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/ctags
GIT_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/git
GRAPHVIZ_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/graphviz
LUAJIT_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/luajit-2.0
NODE_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/node
HUB_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/hub
JQ_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/jq
PECO_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/peco
RBENV_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/rbenv
RUBY_BUILD_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/ruby-build
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

# ruby
RUBY_PATH=${1:-$(which ruby)}

# go
GOROOT=$LOCAL_DIR_PATH/go
GOPATH=~/.go

# go path
HUB_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/github
PECO_GITHUB_DIR_PATH_IN_GOPATH=$GOPATH/src/github.com/peco

# etc
NPM_HOME=~/.npm

# memolist tmp file
MEMOLIST_TMP_FILE=$MEMOLIST_DIR_PATH/0000-00-00-tmp.txt
