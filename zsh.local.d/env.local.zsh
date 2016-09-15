## 環境変数設定
readonly MYSQL_CNCT='mysql mydatabase'  # ~/.my.cnfに設定を書く
readonly MYSQL_CMD="$MYSQL_CNCT -e"
readonly PGSQL_CNCT="psql -h localhost -p 5432 -U guest -d mydatabase"  # ~/.pgpassに設定を書く
readonly PGSQL_CMD="$PGSQL_CNCT -c"

export RBENV_ROOT=~/.rbenv
export GOROOT=$LOCAL_DIR_PATH/go
export GOPATH=~/.go
export GEM_HOME=~/.gem
export NPM_HOME=~/.npm
export MYSQL_CNCT MYSQL_CMD
export MEMOLIST_TMP_FILE=~/memolist/0000-00-00-tmp.txt

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
