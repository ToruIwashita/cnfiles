#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

ANYENV_ROOT=~/.anyenv

export PATH="$PATH:$ANYENV_ROOT/bin"

DEFAULT_RUBY_VERSION=2.5.0
DEFAULT_PYTHON3_VERSION=3.6.4
DEFAULT_PYTHON2_VERSION=2.7.14
DEFAULT_LUA_VERSION='luajit-2.0.5'
DEFAULT_GO_VERSION=1.10.0
DEFAULT_NODE_VERSION=9.8.0
DEFAULT_SCALA_VERSION='scala-2.12.4'
DEFAULT_SBT_VERSION='sbt-0.13.9'

USE_RUBY_VERSION=${USE_RUBY_VERSION:-$DEFAULT_RUBY_VERSION}
USE_PYTHON3_VERSION=${USE_PYTHON3_VERSION:-$DEFAULT_PYTHON3_VERSION}
USE_PYTHON2_VERSION=${USE_PYTHON2_VERSION:-$DEFAULT_PYTHON2_VERSION}
USE_LUA_VERSION=${USE_LUA_VERSION:-$DEFAULT_LUA_VERSION}
USE_GO_VERSION=${USE_GO_VERSION:-$DEFAULT_GO_VERSION}
USE_NODE_VERSION=${USE_NODE_VERSION:-$DEFAULT_NODE_VERSION}
USE_SCALA_VERSION=${USE_SCALA_VERSION:-$DEFAULT_SCALA_VERSION}
USE_SBT_VERSION=${USE_SBT_VERSION:-$DEFAULT_SBT_VERSION}

eval "$(anyenv init -)"

printf "before versions:\n"
echo
anyenv versions
echo

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

if [[ ! $(which ruby) =~ anyenv || ! $(rbenv versions | grep "[- ]$USE_RUBY_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' rbenv install $USE_RUBY_VERSION
fi

rbenv global $USE_RUBY_VERSION
rbenv rehash

if [[ ! $(which python3) =~ anyenv || ! $(pyenv versions | grep "[- ]$USE_PYTHON3_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' pyenv install $USE_PYTHON3_VERSION
fi

if [[ ! $(which python2) =~ anyenv || ! $(pyenv versions | grep "[- ]$USE_PYTHON2_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' pyenv install $USE_PYTHON2_VERSION
fi

pyenv global $USE_PYTHON3_VERSION $USE_PYTHON2_VERSION
pyenv rehash

if [[ ! $(which lua) =~ anyenv || ! $(luaenv versions | grep "[- ]$USE_LUA_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' luaenv install $USE_LUA_VERSION
fi

luaenv global $USE_LUA_VERSION
luaenv rehash

if [[ ! $(which go) =~ anyenv || ! $(goenv versions | grep "[- ]$USE_GO_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' goenv install $USE_GO_VERSION
fi

goenv global $USE_GO_VERSION
goenv rehash

if [[ ! $(which node) =~ anyenv || ! $(nodenv versions | grep "[- ]$USE_NODE_VERSION") ]]; then
  nodenv install $USE_NODE_VERSION
fi

nodenv global $USE_NODE_VERSION
nodenv rehash

if [[ ! $(which scala) =~ anyenv || ! $(scalaenv versions | grep "[- ]$USE_SCALA_VERSION") ]]; then
  scalaenv install $USE_SCALA_VERSION
fi

scalaenv global $USE_SCALA_VERSION
scalaenv rehash

if [[ ! $(which sbt) =~ anyenv || ! $(sbtenv versions | grep "[- ]$USE_SBT_VERSION") ]]; then
  sbtenv install $USE_SBT_VERSION
fi

sbtenv global $USE_SBT_VERSION
sbtenv rehash

echo
printf "after versions:\n"
anyenv versions
echo

printf "complete"

exit 0
