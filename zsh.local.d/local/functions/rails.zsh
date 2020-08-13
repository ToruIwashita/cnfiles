## rails
brails-clear-cache() {
  bundle exec rails assets:clean
  bundle exec rails tmp:cache:clear
}
