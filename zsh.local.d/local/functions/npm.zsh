## npm
build-npm() {
  npm cache clean
  npm install
  npm run build
}

autobuild-npm() {
  build-npm
  npm run watch
}
