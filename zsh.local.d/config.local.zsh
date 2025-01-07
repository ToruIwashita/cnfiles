## ssh-agent
# init-ssh-agent() {
#   eval `ssh-agent`
#   ssh-add ~/.ssh/id_rsa
# }
# init-ssh-agent

## homebrew
# eval "$(/opt/homebrew/bin/brew shellenv | grep -v '^PATH=')"

## direnv
# if (( ${+commands[direnv]} )); then
#   eval "$(direnv hook zsh)"
# fi

## asdf
# source $ASDF_ROOT/asdf.sh

## alias
# git
alias gcs='git commit -m "- update submodules"'
# sbt
alias sbt-c='sbt ~console'
alias sbt-p='sbt ~compile'
alias sbt-r='sbt ~run'
# python
alias pip-r='pipenv run'
# django
alias pjango-m='pipenv run python manage.py'
alias pjango-s='pipenv run python manage.py shell'
alias pjango-r='pipenv run python manage.py runserver'
alias pjango-t='pipenv run python manage.py test --debug-mode'
# django-extentions
alias pjango-sp='pipenv run python manage.py shell_plus --print-sql'
alias pjango-su='pipenv run python manage.py show_urls'
# foreman
alias foreman-s='foreman start'
# rails
alias brails='bundle exec rails'
alias brails-s='bundle exec rails s -e development -b 0.0.0.0 --port 3000'
alias brails-c='bundle exec rails c -e development'
alias brails-r='bundle exec rails r -e development'
# railsに付随するツール
alias bspork='bundle exec spork'
## rails routing
# alias output-routing='bundle exec rails routes >! ~/works/tmp/routing.txt'
# alias archive-routing='[[ -f ~/works/tmp/routing.txt ]] && cp ~/works/tmp/{routing.txt,routing.prev.txt}'
# alias vrouting='vim ~/works/tmp/routing.txt'
# alias drouting='diff ~/works/tmp/routing.txt ~/works/tmp/routing.prev.txt'
# alias output-vrouting='output-routing && vrouting'
# alias output-drouting='output-routing && drouting'
## localstack
# alias localstack-s='DEBUG=true SERVICES=sqs DEFAULT_REGION=ap-northeast-1 HOSTNAME=localstack localstack start'

## for Mac(GNU系のコマンドはシンボリックリンクを貼り直すことを推奨するので以下コメントアウト)
# bindkey
bindkey -v '^sb' immediate-tmp-text-pbcopy      # Ctr+s,pでBUFFERをcatしてpbcopy
bindkey -v '^se' insert-pry                     # Ctr+s,eでpryをBUFFERに入れる
bindkey -v '^s^b' immediate-tmp-markdown-pbcopy # Ctr+s,Ctr+cでtmpファイルをcatしてpbcopy
bindkey -v '^s^e' insert-bundle-exec-pry        # Ctr+s,Ctr+eでbundle exec pryをBUFFERに入れる
