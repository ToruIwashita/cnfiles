## 環境変数設定
# mysql (その他の設定は ~/.my.cnf に書く)
export MYSQL_DATABASE=

# psql (全ての設定を環境変数に書く)
readonly PGHOST=
readonly PGPORT=
readonly PGUSER=
readonly PGPASSWORD=
export PGHOST
export PGPORT
export PGUSER
export PGPASSWORD
export PGDATABASE=

# github (hubコマンド)
readonly GITHUB_TOKEN=
readonly GITHUB_USER_NAME=
export GITHUB_TOKEN
export GITHUB_USER_NAME
export OWNED_GITHUB_REPOSITORIES=()

# anyenv
export ANYENV_ROOT=~/.anyenv

# sbt
export SBT_HOME=~/.sbt

# yarn
export YARN_ROOT=~/.yarn
export YARN_GLOBAL_NODE_MODULES_BIN_PATH=~/.config/yarn/global/node_modules/.bin

# gitインストール時にbrewでインストールしたopensslを使用する
# export CPATH=/opt/homebrew/opt/openssl@3/include:$LD_LIBRARY_PATH

## path
path=(
  $LOCAL_DIR_PATH/bin
  $ANYENV_ROOT/bin
  $YARN_ROOT/bin
  $YARN_GLOBAL_NODE_MODULES_BIN_PATH
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /opt/homebrew/opt/openssl@3/bin

  # brew
  /opt/homebrew/bin
  /opt/homebrew/sbin

  /usr/local/bin
  /usr/local/sbin
  $path
)

## ld_library_path
ld_library_path=(
  $LOCAL_DIR_PATH/lib
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /opt/homebrew/opt/openssl@3/lib
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
