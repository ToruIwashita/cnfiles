#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

sbtenv version

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
addSbtPlugin("org.scala-lang" %% "scala-compiler" % "2.12.3")
EOF

echo
echo
cat $SBT_DIR/plugins/build.sbt

echo
printf "complete"

exit 0
