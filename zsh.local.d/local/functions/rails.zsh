## rails
rbrake-clear-cache() {
  bundle exec rake assets:clean
  bundle exec rake tmp:cache:clear
}
