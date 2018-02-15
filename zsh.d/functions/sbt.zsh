## sbt関連関数
# プロジェクトローカルなsbtoptsを作りたい場合の雛形を作成
gen-sbtopts() {
  cat <<EOF > .sbtopts
-Dsbt.ivy.home=./repository/ivy2
-Divy.home=./repository/ivy2
EOF
}
