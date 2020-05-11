brake-clear-cache() {
  rbenv exec bundle exec rake assets:clean
  rbenv exec bundle exec rake tmp:cache:clear
}
