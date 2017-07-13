# rbenv設定
if [[ -d ~/.rbenv ]]; then
  eval "$(rbenv init -)"
fi

# pyenv設定
if [[ -d ~/.pyenv ]]; then
  eval "$(pyenv init -)"
fi

## alias
# cd
alias cdz="cd $ZSH_DIR_PATH"
alias cdv="cd $VIM_DIR_PATH"
alias cdg="cd $GOPATH"
alias cdl="cd $LOCAL_DIR_PATH"
alias cds="cd $SRC_DIR_PATH"
alias cdw="cd $WORKS_DIR_PATH"
alias cdt="cd $TMP_DIR_PATH"
alias cdc="cd $CNFILES_DIR_PATH"
alias cdm="cd $MARKDOWN_TEXTS_DIR_PATH"
alias cdml="cd $MEMOLIST_DIR_PATH"
# ctags
alias ct='ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,go,ruby'
# rails
alias brails-s='RAILS_ENV=development bundle exec rails s -b 0.0.0.0 --port 3000'
alias brails-c='RAILS_ENV=development bundle exec rails c'
alias brails-r='RAILS_ENV=development bundle exec rails r'
# railsに付随するツール
alias bspork='bundle exec spork'
## rails routing
# alias output-routing='zsh -c "cd ~/works/${project}/; bundle exec rake routes >! ~/works/tmp/routing.txt"'
# alias archive-routing='[[ -f ~/works/tmp/routing.txt ]] && cp ~/works/tmp/{routing.txt,routing.prev.txt}'
# alias vrouting='vim ~/works/tmp/routing.txt'
# alias drouting='diff ~/works/tmp/routing.txt ~/works/tmp/routing.prev.txt'
# alias output-vrouting='output-routing && vrouting'
# alias output-drouting='output-routing && drouting'

## for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
## bindkey
#bindkey -v '^sb' immediate-pbcopy     # Ctr+s,pでBUFFERをcatしてpbcopy
#bindkey -v '^s^b' immediate-tmp-pbcopy # Ctr+s,Ctr+cでtmpファイルをcatしてpbcopy
## alias
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
