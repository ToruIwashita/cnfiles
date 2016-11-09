## 環境変数設定
# mysql (その他の設定は ~/.my.cnf に書く)
readonly MYSQL_DATABASE="crowdworks_dev"
# psql (全ての設定を環境変数に書く)
readonly PGDATABASE=
readonly PGHOST=
readonly PGPORT=
readonly PGUSER=
readonly PGPASSWORD=

export RBENV_ROOT=~/.rbenv
export GOROOT=$LOCAL_DIR_PATH/go
export GOPATH=~/.go
export GEM_HOME=~/.gem
export NPM_HOME=~/.npm
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
  ~/local/bin
  $RBENV_ROOT/shims
  $GOROOT/bin
  $GOPATH/bin
  $GEM_HOME/bin
  $NPM_HOME/bin
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /usr/local/opt/openssl/bin
  /usr/local/bin
  $path
)

## ld_library_path
ld_library_path=(
  ~/local/lib64
  ~/local/lib
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /usr/local/opt/openssl/lib
  $ld_library_path
)
