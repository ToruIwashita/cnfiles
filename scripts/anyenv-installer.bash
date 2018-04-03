#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

ANYENV_ROOT=~/.anyenv

export PATH="$PATH:$ANYENV_ROOT/bin"

RUBY_VERSION=2.5.0
PYTHON3_VERSION=3.6.4
PYTHON2_VERSION=2.7.14
LUA_VERSION='luajit-2.0.5'
GO_VERSION=1.10.0
NODE_VERSION=9.8.0
SCALA_VERSION='scala-2.12.4'
SBT_VERSION='sbt-0.13.9'

USE_RUBY_VERSION=${USE_RUBY_VERSION:-$RUBY_VERSION}
USE_PYTHON3_VERSION=${USE_PYTHON3_VERSION:-$PYTHON3_VERSION}
USE_PYTHON2_VERSION=${USE_PYTHON2_VERSION:-$PYTHON2_VERSION}
USE_LUA_VERSION=${USE_LUA_VERSION:-$LUA_VERSION}
USE_GO_VERSION=${USE_GO_VERSION:-$GO_VERSION}
USE_NODE_VERSION=${USE_NODE_VERSION:-$NODE_VERSION}
USE_SCALA_VERSION=${USE_SCALA_VERSION:-$SCALA_VERSION}
USE_SBT_VERSION=${USE_SBT_VERSION:-$SBT_VERSION}

eval "$(anyenv init -)"

printf "before versions:\n"
echo
anyenv version
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

if [[ ($USE_RUBY_VERSION != $RUBY_VERSION && ! $(rbenv versions | grep "[- ]$USE_RUBY_VERSION")) || ! $(which ruby) =~ anyenv ]]; then
  rbenv install $USE_RUBY_VERSION
fi

rbenv global $USE_RUBY_VERSION
rbenv rehash

if  [[ ($USE_PYTHON3_VERSION != $PYTHON3_VERSION && ! $(pyenv versions | grep "[- ]$USE_PYTHON3_VERSION")) || ! $(which python3) =~ anyenv  ]]; then
  pyenv install $USE_PYTHON3_VERSION
fi

if  [[ ($USE_PYTHON2_VERSION != $PYTHON2_VERSION && ! $(pyenv versions | grep "[- ]$USE_PYTHON2_VERSION")) || ! $(which python2) =~ anyenv  ]]; then
  pyenv install $USE_PYTHON2_VERSION
fi

pyenv global $USE_PYTHON3_VERSION $USE_PYTHON2_VERSION
pyenv rehash

if [[ ($USE_LUA_VERSION != $LUA_VERSION && ! $(luaenv versions | grep "[- ]$USE_LUA_VERSION")) || ! $(which lua) =~ anyenv ]]; then
  luaenv install $USE_LUA_VERSION
fi

luaenv global $USE_LUA_VERSION
luaenv rehash

if [[ ($USE_GO_VERSION != $GO_VERSION && ! $(goenv versions | grep "[- ]$USE_GO_VERSION")) || ! $(which go) =~ anyenv ]]; then
  goenv install $USE_GO_VERSION
fi

goenv global $USE_GO_VERSION
goenv rehash

if [[ ($USE_NODE_VERSION != $NODE_VERSION && ! $(nodenv versions | grep "[- ]$USE_NODE_VERSION")) || ! $(which node) =~ anyenv ]]; then
  nodenv install $USE_NODE_VERSION
fi

nodenv global $USE_NODE_VERSION
nodenv rehash

if [[ ($USE_SCALA_VERSION != $SCALA_VERSION && ! $(scalaenv versions | grep "[- ]$USE_SCALA_VERSION")) || ! $(which scala) =~ anyenv ]]; then
  scalaenv install $USE_SCALA_VERSION
fi

scalaenv global $USE_SCALA_VERSION
scalaenv rehash

if [[ ($USE_SBT_VERSION != $SBT_VERSION && ! $(sbtenv versions | grep "[- ]$USE_SBT_VERSION")) || ! $(which sbt) =~ anyenv ]]; then
  sbtenv install $USE_SBT_VERSION
fi

sbtenv global $USE_SBT_VERSION
sbtenv rehash

echo
printf "after versions:\n"
anyenv version
echo
anyenv versions
echo

printf "complete"

exit 0
