## sbt関連関数
gen-sbtopts() {
  cat <<EOF > .sbtopts
-Dsbt.ivy.home=./repository/ivy2
-Divy.home=./repository/ivy2
EOF
}
