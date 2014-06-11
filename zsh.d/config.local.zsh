## 環境変数設定
readonly MYSQL_CNCT="mysql test"
readonly MYSQL_CMD="$MYSQL_CNCT -e"
readonly AG_BIN=~/local/bin/ag

export EDITOR=~/local/bin/vim                          # ~/local/bin/vimをEDITOR設定
export MYSQL_CNCT MYSQL_CMD
export PATH=~/local/bin:${PATH}                        # ~/local/bin有りの時のサンプル
# export PATH=~/local/bin:/usr/local/git/bin:${PATH}   # for Mac with git
export LD_LIBRARY_PATH=~/local/lib:${LD_LIBRARY_PATH}  # ~/local/lib有りのサンプル

## エイリアス
# mysql
alias my=$MYSQL_CNCT
alias myq=$MYSQL_CMD
alias myshow="$MYSQL_CMD 'SHOW TABLES'"
# ctags
alias ct="ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,ruby"
# silver_searcher
alias ag="ag --nogroup"
# tig
alias tigb="tig blame"
alias tigs="tig status"
# cd
alias cdm="~/markdown_texts"
# apache
alias ap_err="tailf /var/log/httpd/error_log"
alias ap_acc="tailf /var/log/httpd/access_log"

## グローバルエイリアス
alias -g TT=">! ~/works/tmp.txt"
