#!/usr/bin/env bash

__FILE__=$_
BASE_DIR_PATH=$(cd $(dirname $__FILE__);pwd)
BASE_DIR_PATH=${BASE_DIR_PATH%/scripts*}

# OS info
OS_INFO=darwin

# config
CONFIG_DIR_PATH=~/.config

# local dir
LOCAL_DIR_PATH=~/local
LOCAL_BIN_DIR_PATH=$LOCAL_DIR_PATH/bin
LOCAL_LIB_DIR_PATH=$LOCAL_DIR_PATH/lib
LOCAL_JAR_DIR_PATH=$LOCAL_DIR_PATH/jar
LOCAL_INCLUDE_DIR_PATH=$LOCAL_DIR_PATH/include
SUBMODULES_DIR_PATH=$BASE_DIR_PATH/modules

# submodules src dir
ANYENV_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/anyenv
ANYENV_UPDATE_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/anyenv-update
CTAGS_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/ctags
GIT_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/git
GRAPHVIZ_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/graphviz
HUB_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/hub
JQ_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/jq
NEOVIM_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/neovim
PECO_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/peco
THE_SILVER_SEARCHER_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/the_silver_searcher
TMUX_CODE_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/tmux
TMUX_MEM_CPU_LOAD_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/tmux-mem-cpu-load
VIM_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/vim
ZSH_SRC_DIR_PATH=$SUBMODULES_DIR_PATH/zsh

# git
GIT_DIR_PATH=$BASE_DIR_PATH/git

# cache
CACHE_DIR_PATH=~/.cache

# works
WORKS_DIR_PATH=~/works
TMP_DIR_PATH=$WORKS_DIR_PATH/tmp

# log
LOG_DIR_PATH=~/log
MYSQL_LOG_DIR_PATH=$LOG_DIR_PATH/mysql
MYSQL_GENERAL_LOG_FILE_PATH=$MYSQL_LOG_DIR_PATH/query.log
MYSQL_SLOW_QUERY_LOG_FILE_PATH=$MYSQL_LOG_DIR_PATH/slow_query.log

# memolist
MEMOLIST_DIR_PATH=~/.memolist

# memolist task file
MEMOLIST_TASK_TEXT_FILE_PATH=$MEMOLIST_DIR_PATH/0000-00-00-task.txt

# memolist tmp file
MEMOLIST_TMP_DOT_FILE_PATH=$MEMOLIST_DIR_PATH/0000-00-00-tmp.dot
MEMOLIST_TMP_MARKDOWN_FILE_PATH=$MEMOLIST_DIR_PATH/0000-00-00-tmp.md
MEMOLIST_TMP_SQL_FILE_PATH=$MEMOLIST_DIR_PATH/0000-00-00-tmp.sql
MEMOLIST_TMP_TEXT_FILE_PATH=$MEMOLIST_DIR_PATH/0000-00-00-tmp.txt
MEMOLIST_TMP_UML_FILE_PATH=$MEMOLIST_DIR_PATH/0000-00-00-tmp.uml
