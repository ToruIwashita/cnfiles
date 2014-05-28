## 環境変数設定
readonly MYSQL_CNCT="mysql test"
readonly MYSQL_CMD="$MYSQL_CNCT -e"
readonly AG_BIN=~/local/bin/ag

export EDITOR=~/local/bin/vim                         # ~/local/bin/vimをEDITOR設定
export MYSQL_CNCT MYSQL_CMD
export PATH=~/local/bin:${PATH}                       # ~/local/bin有りの時のサンプル
# export PATH=~/local/bin:/usr/local/git/bin:${PATH}  # for Mac with git
export LD_LIBRARY_PATH=~/local/lib:${LD_LIBRARY_PATH} # ~/local/lib有りのサンプル

## エイリアス
# for Mac
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
# CD系
alias cdm="~/markdown_texts"
# MYSQL系
alias my=$MYSQL_CNCT
alias myq=$MYSQL_CMD
alias myshow="$MYSQL_CMD 'SHOW TABLES'"

## グローバルエイリアス
alias -g TT=">! ~/works/tmp.txt"

