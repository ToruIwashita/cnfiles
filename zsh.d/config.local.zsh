## 環境変数設定
readonly MYSQL_CNCT="mysql test"
readonly MYSQL_CMD="$MYSQL_CNCT -e"

export EDITOR=~/local/bin/vim
export MYSQL_CNCT MYSQL_CMD
export PATH=~/local/bin:${PATH}                       # ~/local/bin有りの時のサンプル
export LD_LIBRARY_PATH=~/local/lib:${LD_LIBRARY_PATH} # ~/local/lib有りのサンプル
export EDITOR=~/local/bin/vim                         # ~/local/bin/vimをEDITOR設定

## エイリアス
# CD系
alias cdm="~/MEMOs"
# MYSQL系
alias my=$MYSQL_CNCT
alias myq=$MYSQL_CMD
alias myshow="$MYSQL_CMD 'SHOW TABLES'"

## グローバルエイリアス
alias -g TT=">! ~/works/tmp.txt"

