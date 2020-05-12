## `python3 -m venv .venv`
#chpwd_functions+='source-venv'

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
# bundle
alias rbundle='rbenv exec bundle'
# foreman
alias rforeman-s='rbenv exec foreman start'
# rails
alias rbrails-s='rbenv exec bundle exec rails s -e development -b 0.0.0.0 --port 3000'
alias rbrails-c='rbenv exec bundle exec rails c -e development'
alias rbrails-r='rbenv exec bundle exec rails r -e development'
# railsに付随するツール
alias rbspork='rbenv exec bundle exec spork'
## rails routing
# alias output-routing='rbenv exec bundle exec rake routes >! ~/works/tmp/routing.txt'
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
