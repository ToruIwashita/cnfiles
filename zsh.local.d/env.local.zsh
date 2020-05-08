## 環境変数設定
# mysql (その他の設定は ~/.my.cnf に書く)
readonly MYSQL_DATABASE=

# psql (全ての設定を環境変数に書く)
readonly PGDATABASE=
readonly PGHOST=
readonly PGPORT=
readonly PGUSER=
readonly PGPASSWORD=

# anyenv
export ANYENV_ROOT=~/.anyenv
# sbt
export SBT_HOME=~/.sbt
# yarn
export YARN_ROOT=~/.yarn
export YARN_GLOBAL_NODE_MODULES_BIN_PATH=~/.config/yarn/global/node_modules/.bin
# DB
export MYSQL_DATABASE
export PGDATABASE
export PGHOST
export PGPORT
export PGUSER
export PGPASSWORD
# github
# api token (hubコマンド)
export GITHUB_TOKEN=
# user name
export GITHUB_USER_NAME=
# repositories
export OWNED_GITHUB_REPOSITORIES=()

# gitインストール時にbrewでインストールしたopensslを使用する
# export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH

## path
path=(
  $LOCAL_DIR_PATH/bin
  $ANYENV_ROOT/bin
  $YARN_ROOT/bin
  $YARN_GLOBAL_NODE_MODULES_BIN_PATH
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /usr/local/opt/openssl/bin
  /usr/local/bin
  $path
)

## ld_library_path
ld_library_path=(
  $LOCAL_DIR_PATH/lib
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /usr/local/opt/openssl/lib
  $ld_library_path
)

## fpath
fpath=(
  $zsh_inits_dir_path
  $fpath
)

## anyenv設定
if [[ -d $ANYENV_ROOT ]]; then
  eval "$(anyenv init -)"
fi

## go
if [[ $(which go) =~ anyenv ]]; then
  export GOROOT=$(go env GOROOT)
  export GOPATH=$(go env GOPATH)

  path=(
    $GOPATH/bin
    $path
  )
fi

## node
if [[ $(which node) =~ anyenv ]]; then
  export NODE_PATH=$(npm root -g)
fi

## lua
if [[ $(which lua) =~ anyenv ]]; then
  local luajit_path luajit_prefix_dir

  luajit_path=${1:-$(which luajit)}
  luajit_prefix_dir=$ANYENV_ROOT/envs/luaenv/versions/$(luaenv version | sed -e 's/ .*$//g')

  ld_library_path=(
    $luajit_prefix_dir/lib
    $ld_library_path
  )
fi
