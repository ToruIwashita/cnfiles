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

anyenv install rbenv
anyenv install pyenv
anyenv install luaenv
anyenv install goenv
anyenv install nodenv
anyenv install scalaenv
anyenv install sbtenv

rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv rehash

pyenv install $PYTHON3_VERSION
pyenv install $PYTHON2_VERSION
pyenv global $PYTHON3_VERSION $PYTHON2_VERSION
pyenv rehash

luaenv install $LUA_VERSION
luaenv global $LUA_VERSION
luaenv rehash

goenv install $GO_VERSION
goenv global $GO_VERSION
goenv rehash

nodenv install $NODE_VERSION
nodenv global $NODE_VERSION
nodenv rehash

scalaenv install $SCALA_VERSION
scalaenv global $SCALA_VERSION
scalaenv rehash

sbtenv install $SBT_VERSION
sbtenv global $SBT_VERSION
sbtenv rehash

echo
printf "after versions:\n"
anyenv version
echo
anyenv versions

echo
printf "complete"

exit 0
