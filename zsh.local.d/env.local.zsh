## 環境変数設定
# mysql (その他の設定は ~/.my.cnf に書く)
readonly MYSQL_DATABASE=

# psql (全ての設定を環境変数に書く)
readonly PGDATABASE=
readonly PGHOST=
readonly PGPORT=
readonly PGUSER=
readonly PGPASSWORD=

# programming language environment
export RBENV_ROOT=~/.rbenv
export PYENV_ROOT=~/.pyenv
export SCALAENV_ROOT=~/.scalaenv
export SBTENV_ROOT=~/.sbtenv
# programming language environment variable
export SBT_HOME=~/.sbt
export GOROOT=$LOCAL_DIR_PATH/go
export GOPATH=~/.go
export NPM_HOME=~/.npm
# DB
export MYSQL_DATABASE
export PGDATABASE
export PGHOST
export PGPORT
export PGUSER
export PGPASSWORD

# gitインストール時にbrewでインストールしたopensslを使用する
# export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH

## path
path=(
  $LOCAL_DIR_PATH/bin
  $RBENV_ROOT/bin
  $PYENV_ROOT/bin
  $SCALAENV_ROOT/bin
  $SBTENV_ROOT/bin
  $GOROOT/bin
  $GOPATH/bin
  $NPM_HOME/bin
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
  $fpath
)
