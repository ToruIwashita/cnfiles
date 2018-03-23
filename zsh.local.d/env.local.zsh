## 環境変数設定
# mysql (その他の設定は ~/.my.cnf に書く)
readonly MYSQL_DATABASE=

# psql (全ての設定を環境変数に書く)
readonly PGDATABASE=
readonly PGHOST=
readonly PGPORT=
readonly PGUSER=
readonly PGPASSWORD=
# hubコマンド用
readonly GITHUB_API_TOKEN=

# programming language env environment variable
export ANYENV_ROOT=~/.anyenv
# programming language environment variable
export SBT_HOME=~/.sbt
# DB
export MYSQL_DATABASE
export PGDATABASE
export PGHOST
export PGPORT
export PGUSER
export PGPASSWORD
# github
# api token (hubコマンド)
export GITHUB_API_TOKEN
# user name
export GITHUB_USER_NAME
# repositories
export OWNED_GITHUB_REPOSITORIES=()

# gitインストール時にbrewでインストールしたopensslを使用する
# export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH

## path
path=(
  $LOCAL_DIR_PATH/bin
  $ANYENV_ROOT/bin
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
