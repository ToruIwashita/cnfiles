# rbenv設定
if [[ -d ~/.rbenv  ]]; then
  eval "$(rbenv init - zsh 2>/dev/null)"
fi

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
