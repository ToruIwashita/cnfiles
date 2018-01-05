## ctags関連関数
create-tags() {
  ctags -f .tags
}

create-sbt-tags() {
  sbt gen-ctags
}
