# AIエージェントなどzsh -l -c（ログインシェルx非インタラクティブシェル）でコマンドが実行される場合にもzshrcを読み込ませる
[[ -o interactive ]] || source ~/.zshrc

# vim: ft=zsh
