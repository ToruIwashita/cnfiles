#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

$(cd $BASE_DIR_PATH;git submodule update --init)

## create base dir
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

# local jar dir
if [[ -d $LOCAL_JAR_DIR_PATH ]]; then
  printf "\e[32m$LOCAL_JAR_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $LOCAL_JAR_DIR_PATH\e[0m\n"
  mkdir $LOCAL_JAR_DIR_PATH
fi

# config
if [[ -d $CONFIG_DIR_PATH ]]; then
  printf "\e[32m$CONFIG_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $CONFIG_DIR_PATH dir\e[0m\n"
  mkdir $CONFIG_DIR_PATH
fi

# cache dir
if [[ -d $CACHE_DIR_PATH ]]; then
  printf "\e[32m$CACHE_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $CACHE_DIR_PATH\e[0m\n"
  mkdir $CACHE_DIR_PATH
fi

# log dir
if [[ -d $LOG_DIR_PATH ]]; then
  printf "\e[32m$LOG_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $LOG_DIR_PATH\e[0m\n"
  mkdir $LOG_DIR_PATH
fi

# mysql log dir
if [[ -d $MYSQL_LOG_DIR_PATH ]]; then
  printf "\e[32m$MYSQL_LOG_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $MYSQL_LOG_DIR_PATH\e[0m\n"
  mkdir $MYSQL_LOG_DIR_PATH
fi

# zsh.d/local dir
if [[ -d $BASE_DIR_PATH/zsh.d/local ]]; then
  printf "\e[32m$BASE_DIR_PATH/zsh.d/local dir already exists\e[0m\n"
else
  printf "\e[31mcopy dir $BASE_DIR_PATH/zsh.local.d/local to $BASE_DIR_PATH/zsh.d/local\e[0m\n"
  cp -rp $BASE_DIR_PATH/zsh.local.d/local $BASE_DIR_PATH/zsh.d
fi

# works dir
if [[ -d $WORKS_DIR_PATH ]]; then
  printf "\e[32m$WORKS_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $WORKS_DIR_PATH\e[0m\n"
  mkdir $WORKS_DIR_PATH
fi

# works cursor workspaces dir
if [[ -d $CURSOR_WORKSPACES_DIR_PATH ]]; then
  printf "\e[32m$CURSOR_WORKSPACES_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir -p $CURSOR_WORKSPACES_DIR_PATH\e[0m\n"
  mkdir -p $CURSOR_WORKSPACES_DIR_PATH
fi

# works tmp dir
if [[ -d $TMP_DIR_PATH ]]; then
  printf "\e[32m$TMP_DIR_PATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $TMP_DIR_PATH\e[0m\n"
  mkdir $TMP_DIR_PATH
fi

# works memolist dir
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

## copy my.cnf file
if [[ -f $BASE_DIR_PATH/my.local.cnf ]]; then
  printf "\e[32m$BASE_DIR_PATH/my.local.cnf file already exists\e[0m\n"
else
  printf "\e[31mcopy file $BASE_DIR_PATH/my.cnf to $BASE_DIR_PATH/my.local.cnf\e[0m\n"
  cp -p $BASE_DIR_PATH/my.cnf $BASE_DIR_PATH/my.local.cnf
fi

## copy github-markdown-css/github-markdown-dark.css file
if [[ -f $CONFIG_DIR_PATH/github-markdown-dark.css ]]; then
  printf "\e[32m$CONFIG_DIR_PATH/github-markdown-dark.css file already exists\e[0m\n"
else
  printf "\e[31mcopy file $BASE_DIR_PATH/modules/github-markdown-css/github-markdown-dark.css to $CONFIG_DIR_PATH/github-markdown-dark.css\e[0m\n"
  cp -p $BASE_DIR_PATH/modules/github-markdown-css/github-markdown-dark.css $CONFIG_DIR_PATH/github-markdown-dark.css
fi

# zsh
if [[ -L ~/.zprofile ]]; then
  printf "\e[32m~/.zprofile  symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.zprofile \e[0m\n"
  ln -is $BASE_DIR_PATH/zprofile  ~/.zprofile
fi

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
  ln -isn $BASE_DIR_PATH/tmux ~/.tmux
fi

# claude
if [[ -d ~/.claude ]]; then
  printf "\e[32m~/.claude dir already exists\e[0m\n"
else
  printf "\e[31mmkdir ~/.claude\e[0m\n"
  mkdir ~/.claude
fi

if [[ -L ~/.claude/settings.json ]]; then
  printf "\e[32m~/.claude/settings.json symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.claude/settings.json\e[0m\n"
  ln -is $BASE_DIR_PATH/claude/settings.json ~/.claude/settings.json
fi

# gemini
if [[ -d ~/.gemini ]]; then
  printf "\e[32m~/.gemini dir already exists\e[0m\n"
else
  printf "\e[31mmkdir ~/.gemini\e[0m\n"
  mkdir ~/.gemini
fi

if [[ -L ~/.gemini/settings.json ]]; then
  printf "\e[32m~/.gemini/settings.json symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.gemini/settings.json\e[0m\n"
  ln -is $BASE_DIR_PATH/gemini/settings.json ~/.gemini/settings.json
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
  printf "\e[32m~/.gitignore symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.gitignore \e[0m\n"
  ln -is $GIT_DIR_PATH/gitignore ~/.gitignore
fi

# peco
if [[ -L ~/.peco ]]; then
  printf "\e[32m~/.peco dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.peco dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/peco ~/.peco
fi

# delve
if [[ -L ~/.dlv ]]; then
  printf "\e[32m~/.dlv dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.dlv dir\e[0m\n"
  ln -isn $BASE_DIR_PATH/dlv ~/.dlv
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

# karabiner
if [[ -L $CONFIG_DIR_PATH/karabiner ]]; then
  printf "\e[32m$CONFIG_DIR_PATH/karabiner symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $CONFIG_DIR_PATH/karabiner\e[0m\n"
  ln -is $BASE_DIR_PATH/config/karabiner $CONFIG_DIR_PATH/karabiner
fi

# flake8
if [[ -L $CONFIG_DIR_PATH/flake8 ]]; then
  printf "\e[32m$CONFIG_DIR_PATH/flake8 symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $CONFIG_DIR_PATH/flake8\e[0m\n"
  ln -is $BASE_DIR_PATH/config/flake8 $CONFIG_DIR_PATH/flake8
fi

# black
if [[ -L $CONFIG_DIR_PATH/black ]]; then
  printf "\e[32m$CONFIG_DIR_PATH/black symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $CONFIG_DIR_PATH/black\e[0m\n"
  ln -is $BASE_DIR_PATH/config/black $CONFIG_DIR_PATH/black
fi

# mypy
if [[ -L $CONFIG_DIR_PATH/mypy ]]; then
  printf "\e[32m$CONFIG_DIR_PATH/mypy dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $CONFIG_DIR_PATH/mypy dir\e[0m\n"
  ln -is $BASE_DIR_PATH/config/mypy $CONFIG_DIR_PATH/mypy
fi

# eslint
if [[ -L ~/.eslintrc.json ]]; then
  printf "\e[32m~/.eslintrc.json symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.eslintrc.json\e[0m\n"
  ln -is $BASE_DIR_PATH/eslintrc.json ~/.eslintrc.json
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

# my.cnf
if [[ -L ~/.my.cnf ]]; then
  printf "\e[32m~/.my.cnf symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.my.cnf\e[0m\n"
  ln -is $BASE_DIR_PATH/my.local.cnf ~/.my.cnf
fi

## create initial file
# mysql general_log
if [[ -f $MYSQL_GENERAL_LOG_FILE_PATH ]]; then
  printf "\e[32m$MYSQL_GENERAL_LOG_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MYSQL_GENERAL_LOG_FILE_PATH\e[0m\n"
  touch $MYSQL_GENERAL_LOG_FILE_PATH
fi

# mysql slow_query
if [[ -f $MYSQL_SLOW_QUERY_LOG_FILE_PATH ]]; then
  printf "\e[32m$MYSQL_SLOW_QUERY_LOG_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MYSQL_SLOW_QUERY_LOG_FILE_PATH\e[0m\n"
  touch $MYSQL_SLOW_QUERY_LOG_FILE_PATH
fi

# tmux-display-message
if [[ -L $LOCAL_BIN_DIR_PATH/tmux-display-message ]]; then
  printf "\e[32m$LOCAL_BIN_DIR_PATH/tmux-display-message symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $LOCAL_BIN_DIR_PATH/tmux-display-message\e[0m\n"
  ln -is $BASE_DIR_PATH/local/bin/tmux-display-message $LOCAL_BIN_DIR_PATH/tmux-display-message
fi

# plantuml.jar
if [[ -L $LOCAL_JAR_DIR_PATH/plantuml.jar ]]; then
  printf "\e[32m$LOCAL_JAR_DIR_PATH/plantuml.jar symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $LOCAL_JAR_DIR_PATH/plantuml.jar\e[0m\n"
  ln -is $BASE_DIR_PATH/local/jar/plantuml.jar $LOCAL_JAR_DIR_PATH/plantuml.jar
fi

# memolist task markdown file
if [[ -f $MEMOLIST_TASK_MARKDOWN_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TASK_MARKDOWN_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TASK_MARKDOWN_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TASK_MARKDOWN_FILE_PATH
fi

# memolist tmp markdown file
if [[ -f $MEMOLIST_TMP_MARKDOWN_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TMP_MARKDOWN_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_MARKDOWN_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TMP_MARKDOWN_FILE_PATH
fi

# memolist tmp sql file
if [[ -f $MEMOLIST_TMP_SQL_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TMP_SQL_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_SQL_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TMP_SQL_FILE_PATH
fi

# memolist tmp text file
if [[ -f $MEMOLIST_TMP_TEXT_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TMP_TEXT_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_TEXT_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TMP_TEXT_FILE_PATH
fi

# memolist tmp uml file
if [[ -f $MEMOLIST_TMP_UML_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TMP_UML_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_UML_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TMP_UML_FILE_PATH
fi

# memolist tmp json file
if [[ -f $MEMOLIST_TMP_JSON_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TMP_JSON_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_JSON_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TMP_JSON_FILE_PATH
fi

# memolist tmp ruby file
if [[ -f $MEMOLIST_TMP_RUBY_FILE_PATH ]]; then
  printf "\e[32m$MEMOLIST_TMP_RUBY_FILE_PATH file already exists\e[0m\n"
else
  printf "\e[31mcreate file $MEMOLIST_TMP_RUBY_FILE_PATH\e[0m\n"
  touch $MEMOLIST_TMP_RUBY_FILE_PATH
fi

# markdown_texts code implementation guide dir
if [[ -L $DOCS_DIR_PATH/code_implementation_guide ]]; then
  printf "\e[32m$DOCS_DIR_PATH/code_implementation_guide dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink $DOCS_DIR_PATH/code_implementation_guide dir\e[0m\n"
  ln -isn $MARKDOWN_TEXTS_DIR_PATH/agentic_coding/code_implementation_guide $DOCS_DIR_PATH/code_implementation_guide
fi

# markdown_texts agents dir
if [[ -L ~/.claude/agents ]]; then
  printf "\e[32m~/.claude/agents dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.claude/agents dir\e[0m\n"
  ln -is $MARKDOWN_TEXTS_DIR_PATH/claude/agents ~/.claude/agents
fi

# markdown_texts commands dir
if [[ -L ~/.claude/commands ]]; then
  printf "\e[32m~/.claude/commands dir symlink already exists\e[0m\n"
else
  printf "\e[31mcreate symlink ~/.claude/commands dir\e[0m\n"
  ln -is $MARKDOWN_TEXTS_DIR_PATH/agentic_coding/commands ~/.claude/commands
fi

# text replacement
sed -e 's/\.markdown-body/#body/g' $CONFIG_DIR_PATH/github-markdown-dark.css > $CONFIG_DIR_PATH/github-markdown-dark.css.tmp
mv -f $CONFIG_DIR_PATH/github-markdown-dark.css.tmp $CONFIG_DIR_PATH/github-markdown-dark.css

printf "\ninit complete\n"
exit 0
