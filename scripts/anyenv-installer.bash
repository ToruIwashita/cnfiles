#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

RUBY_VERSION=2.5.0
PYTHON3_VERSION=3.6.4
PYTHON2_VERSION=2.7.14
LUA_VERSION='luajit-2.0.5'
GO_VERSION=1.10.0
NODE_VERSION=9.8.0
SCALA_VERSION='scala-2.12.4'
SBT_VERSION='sbt-0.13.9'

printf "before versions:\n"
echo
anyenv version
echo
anyenv versions

if [[ ! $(which rbenv) ]]; then
  anyenv install rbenv
fi

if [[ ! $(which pyenv) ]]; then
  anyenv install pyenv
fi

if [[ ! $(which luaenv) ]]; then
  anyenv install luaenv
fi

if [[ ! $(which goenv) ]]; then
  anyenv install goenv
fi

if [[ ! $(which nodenv) ]]; then
  anyenv install nodenv
fi

if [[ ! $(which scalaenv) ]]; then
  anyenv install scalaenv
fi

if [[ ! $(which sbtenv) ]]; then
  anyenv install sbtenv
fi

if [[ ! $(which ruby) =~ anyenv ]]; then
  rbenv install $RUBY_VERSION
  rbenv global $RUBY_VERSION
  rbenv rehash
fi

if  [[ (! $(which python2) =~ anyenv) || ! $(which python3) =~ anyenv  ]]; then
  pyenv install $PYTHON3_VERSION
  pyenv install $PYTHON2_VERSION
  pyenv global $PYTHON3_VERSION $PYTHON2_VERSION
  pyenv rehash
fi

if [[ ! $(which lua) =~ anyenv ]]; then
  luaenv install $LUA_VERSION
  luaenv global $LUA_VERSION
  luaenv rehash
fi

if [[ ! $(which go) =~ anyenv ]]; then
  goenv install $GO_VERSION
  goenv global $GO_VERSION
  goenv rehash
fi

if [[ ! $(which node) =~ anyenv ]]; then
  nodenv install $NODE_VERSION
  nodenv global $NODE_VERSION
  nodenv rehash
fi

if [[ ! $(which scala) =~ anyenv ]]; then
  scalaenv install $SCALA_VERSION
  scalaenv global $SCALA_VERSION
  scalaenv rehash
fi

if [[ ! $(which sbt) =~ anyenv ]]; then
  sbtenv install $SBT_VERSION
  sbtenv global $SBT_VERSION
  sbtenv rehash
fi

echo
printf "after versions:\n"
anyenv version
echo
anyenv versions

echo
printf "complete"

exit 0
