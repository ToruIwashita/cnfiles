# 環境変数設定
readonly MYSQL_CNCT='mysql --defaults-extra-file=~/.my.cnf test'
readonly MYSQL_CMD="$MYSQL_CNCT -e"

export EDITOR=~/local/bin/vim
export GOROOT=~/local/go
export GOPATH=~/.go
export GEM_HOME=~/.gem
export NPM_HOME=~/.npm
export MYSQL_CNCT MYSQL_CMD

# path関連環境変数
path=(
  ~/local/bin
  $GOROOT/bin
  $GOPATH/bin
  $GEM_HOME/bin
  $NPM_HOME/bin
  /usr/local/bin
  $path
)
ld_library_path=(
  ~/local/lib64
  ~/local/lib
  $ld_library_path
)

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
# ctags
alias ct='ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,go,ruby'
# tig
alias tigb='tig blame'
alias tigs='tig status'

## global alias
alias -g TT='>! ~/works/tmp.txt'

## for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
## bindkey
#bindkey -v '^sp' pbcopy-current # Ctr+s,pでBUFFERをcatしてpbcopy
## alias
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
