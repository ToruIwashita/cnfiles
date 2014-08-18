## 環境変数設定
readonly MYSQL_CNCT="mysql test"
readonly MYSQL_CMD="$MYSQL_CNCT -e"

export EDITOR=~/local/bin/vim
export GOROOT=~/local/go
export GOPATH=~/.go
export MYSQL_CNCT MYSQL_CMD

# path
export PATH=~/local/bin:$GOROOT/bin:$GOPATH/bin:$PATH
export LD_LIBRARY_PATH=~/local/lib64:~/local/lib:$LD_LIBRARY_PATH

## エイリアス
# mysql
alias my=$MYSQL_CNCT
alias myq=$MYSQL_CMD
alias myshow="$MYSQL_CMD 'SHOW TABLES'"
# ctags
alias ct='ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,go,ruby'
# tig
alias tigb='tig blame'
alias tigs='tig status'

## グローバルエイリアス
alias -g TT='>! ~/works/tmp.txt'

# for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
