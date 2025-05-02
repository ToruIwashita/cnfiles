## rails
brails-clear-cache() {
  bundle exec rails assets:clean
  bundle exec rails tmp:cache:clear
}

tailf-main-started-log() {
  if (( ! $# )); then
    print 'lack of arguments.' 2>&1
    return 1
  fi

  tail -f $* | grep --line-buffered -v 'OPTIONS' | grep --line-buffered 'INFO -- : Started'
}
