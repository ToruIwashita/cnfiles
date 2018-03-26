#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which sbt)} =~ anyenv ]]; then
  printf "there is no sbt installed with anyenv\n"
  exit 1
fi

# scala
SBT_DIR=~/.sbt/$(sbtenv version | sed -e 's/^sbt-\([0-9]*.[0-9]*\).*/\1/g')

printf "sbt version:\n"
sbt sbt-version

echo
which sbt

echo
if [[ -d $SBT_DIR/plugins ]]; then
  printf "\e[32m$SBT_DIR/plugins dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $SBT_DIR/plugins\e[0m\n"
  mkdir $SBT_DIR/plugins
fi

echo
printf "add sbt plugins"

cat <<EOF > $SBT_DIR/plugins/build.sbt
addSbtPlugin("org.scala-debugger" %% "sbt-scala-debugger" % "1.1.0-M3")
addSbtPlugin("net.ceedubs" %% "sbt-ctags" % "0.2.0")
EOF

echo
echo
cat $SBT_DIR/plugins/build.sbt

echo
printf "complete"

exit 0
