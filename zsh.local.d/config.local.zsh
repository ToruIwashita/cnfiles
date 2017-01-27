# rbenv設定
if [[ -d ~/.rbenv  ]]; then
  eval "$(rbenv init - zsh 2>/dev/null)"
fi

## alias
# cd
alias cdz="cd $ZSH_DIR_PATH"
alias cdv="cd $VIM_DIR_PATH"
alias cdg='cd ~/.go'
alias cdl="cd $LOCAL_DIR_PATH"
alias cds='cd ~/src'
alias cdsg='cd ~/src/go'
alias cdw='cd ~/works'
alias cdc='cd ~/.cnfiles'
alias cdml='cd ~/.memolist'
# ctags
alias ct='ctags -f .tags --recurse --tag-relative --sort=yes --languages=sh,go,ruby'
# rails
alias brails-s='RAILS_ENV=development bundle exec rails s -b 0.0.0.0 --port 3000'
alias brails-c='RAILS_ENV=development bundle exec rails c'
alias brails-r='RAILS_ENV=development bundle exec rails r'
# rails routing
# alias output-routing='zsh -c "cd ~/works/${project}/; bundle exec rake routes >! ~/works/tmp/routing.txt"'
# alias archive-routing='[[ -f ~/works/tmp/routing.txt ]] && cp ~/works/tmp/{routing.txt,routing.prev.txt}'
# alias vrouting='vim ~/works/tmp/routing.txt'
# alias drouting='diff ~/works/tmp/routing.txt ~/works/tmp/routing.prev.txt'
# alias output-vrouting='output-routing && vrouting'
# alias output-drouting='output-routing && drouting'
# railsに付随するツール
alias bspork='bundle exec spork'

## for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
## bindkey
#bindkey -v '^sb' immediate-pbcopy     # Ctr+s,pでBUFFERをcatしてpbcopy
#bindkey -v '^sb' immediate-tmp-pbcopy # Ctr+s,Ctr+cでtmpファイルをcatしてpbcopy
## alias
#alias ls="gls -F --color"
#alias find="gfind"
#alias xargs="gxargs"
