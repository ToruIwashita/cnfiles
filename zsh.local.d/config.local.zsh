## 環境変数設定
readonly MYSQL_CNCT="mysql test"
readonly MYSQL_CMD="$MYSQL_CNCT -e"

export CNBUNDLE=~/.cnbundle
export EDITOR=~/local/bin/vim
export GEM_HOME=$CNBUNDLE/ruby
export GOROOT=~/local/go
export GOPATH=~/.go
export MYSQL_CNCT MYSQL_CMD

# path関連環境変数
export PATH=~/local/bin:$GOROOT/bin:$GOPATH/bin:/usr/local/bin:$PATH  # gem,node-packageのパス追加必要
export LD_LIBRARY_PATH=~/local/lib64:~/local/lib:$LD_LIBRARY_PATH

## エイリアス
# cd
alias cdz='cd ~/.zsh.d'
alias cdv='cd ~/.vim'
alias cdg='cd ~/.go'
alias cdl='cd ~/local'
alias cds='cd ~/src'
alias cdb='cd ~/.cnbundle'
alias cdsg='cd ~/src/go'
alias cdw='cd ~/works'
alias cdc='cd ~/.cnfiles'
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
