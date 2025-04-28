## rails
brails-clear-cache() {
  bundle exec rails assets:clean
  bundle exec rails tmp:cache:clear
}

tailf-main-started-log() {
  tail -f $* | grep --line-buffered -v 'OPTIONS' | grep --line-buffered 'INFO -- : Started'
}
