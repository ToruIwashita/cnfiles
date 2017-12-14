# rbenv設定
if [[ -d $RBENV_ROOT ]]; then
  eval "$(rbenv init -)"
fi

# pyenv設定
if [[ -d $PYENV_ROOT ]]; then
  eval "$(pyenv init -)"
fi

# scalaenv設定
if [[ -d $SCALAENV_ROOT ]]; then
  eval "$(scalaenv init -)"
fi

# sbtenv設定
if [[ -d $SBTENV_ROOT ]]; then
  eval "$(sbtenv init -)"
fi

## alias
# git
alias gcs='git commit -m "- update submodules"'
# sbt
alias sbt-c='sbt ~console'
alias sbt-p='sbt ~compile'
alias sbt-r='sbt ~run'
# rails
alias brails-s='RAILS_ENV=development bundle exec rails s -b 0.0.0.0 --port 3000'
alias brails-c='RAILS_ENV=development bundle exec rails c'
alias brails-r='RAILS_ENV=development bundle exec rails r'
# railsに付随するツール
alias bspork='bundle exec spork'
# alias localstack-s='DEBUG=true SERVICES=sqs DEFAULT_REGION=ap-northeast-1 HOSTNAME=localstack localstack start'
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
