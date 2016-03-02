# 環境変数設定
readonly MYSQL_CNCT='mysql mydatabase'  # ~/.my.cnfに設定を書く
readonly MYSQL_CMD="$MYSQL_CNCT -e"
readonly PGSQL_CNCT="psql -h localhost -p 5432 -U guest -d mydatabase"  # ~/.pgpassに設定を書く
readonly PGSQL_CMD="$PGSQL_CNCT -c"

export EDITOR=vim
export RBENV_ROOT=~/.rbenv
export GOROOT=~/local/go
export GOPATH=~/.go
export GEM_HOME=~/.gem
export NPM_HOME=~/.npm
export MYSQL_CNCT MYSQL_CMD
export TMP=~/works/tmp/tmp.txt

# rbenv設定
if [[ -d ~/.rbenv  ]]; then
  eval "$(rbenv init - zsh 2>/dev/null)"
fi

# path関連環境変数
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
ld_library_path=(
  ~/local/lib64
  ~/local/lib
  # gitインストール時にbrewでインストールしたopensslを使用する
  # /usr/local/opt/openssl/lib
  $ld_library_path
)
# gitインストール時にbrewでインストールしたopensslを使用する
# export CPATH=/usr/local/opt/openssl/include:$LD_LIBRARY_PATH

## alias
# cd
alias cdz='cd ~/.zsh.d'
alias cdv='cd ~/.vim'
alias cdg='cd ~/.go'
alias cdl='cd ~/local'
alias cds='cd ~/src'
alias cdsg='cd ~/src/go'
alias cdw='cd ~/works'
alias cdc='cd ~/.cnfiles'
# mysql
alias my=$MYSQL_CNCT
alias myq=$MYSQL_CMD
alias myshow="$MYSQL_CMD 'SHOW TABLES'"
# pgsql
alias pg=$PGSQL_CNCT
alias pgq=$PGSQL_CMD
alias pgshow="$PGSQL_CMD '\d'"
# ctags
alias ct='ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,go,ruby'
# tig
alias tigb='tig blame'
alias tigs='tig status'
alias tigr='tig refs'

## global alias
alias -g TT='>! ~/works/tmp.txt'

## for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
## bindkey
#bindkey -v '^sc' pbcopy-current # Ctr+s,pでBUFFERをcatしてpbcopy
## alias
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
