## ls関数
colorful-ls() {
  if type gls > /dev/null 2>&1; then
    gls -F --color
  else
    ls -F --color
  fi
}
