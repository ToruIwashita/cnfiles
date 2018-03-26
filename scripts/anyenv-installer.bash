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

NEW_RUBY_VERSION=${NEW_RUBY_VERSION:-$RUBY_VERSION}
NEW_PYTHON3_VERSION=${NEW_PYTHON3_VERSION:-$PYTHON3_VERSION}
NEW_PYTHON2_VERSION=${NEW_PYTHON2_VERSION:-$PYTHON2_VERSION}
NEW_LUA_VERSION=${NEW_LUA_VERSION:-$LUA_VERSION}
NEW_GO_VERSION=${NEW_GO_VERSION:-$GO_VERSION}
NEW_NODE_VERSION=${NEW_NODE_VERSION:-$NODE_VERSION}
NEW_SCALA_VERSION=${NEW_SCALA_VERSION:-$SCALA_VERSION}
NEW_SBT_VERSION=${NEW_SBT_VERSION:-$SBT_VERSION}

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

if [[ ($NEW_RUBY_VERSION != $RUBY_VERSION && ! $(rbenv versions | grep "[- ]$NEW_RUBY_VERSION")) || ! $(which ruby) =~ anyenv ]]; then
  rbenv install $NEW_RUBY_VERSION
fi

rbenv global $NEW_RUBY_VERSION
rbenv rehash

if  [[ ($NEW_PYTHON3_VERSION != $PYTHON3_VERSION && ! $(pyenv versions | grep "[- ]$NEW_PYTHON3_VERSION")) || ! $(which python3) =~ anyenv  ]]; then
  pyenv install $NEW_PYTHON3_VERSION
fi

if  [[ ($NEW_PYTHON2_VERSION != $PYTHON2_VERSION && ! $(pyenv versions | grep "[- ]$NEW_PYTHON2_VERSION")) || ! $(which python2) =~ anyenv  ]]; then
  pyenv install $NEW_PYTHON2_VERSION
fi

pyenv global $NEW_PYTHON3_VERSION $NEW_PYTHON2_VERSION
pyenv rehash

if [[ ($NEW_LUA_VERSION != $LUA_VERSION && ! $(luaenv versions | grep "[- ]$NEW_LUA_VERSION")) || ! $(which lua) =~ anyenv ]]; then
  luaenv install $NEW_LUA_VERSION
fi

luaenv global $NEW_LUA_VERSION
luaenv rehash

if [[ ($NEW_GO_VERSION != $GO_VERSION && ! $(goenv versions | grep "[- ]$NEW_GO_VERSION")) || ! $(which go) =~ anyenv ]]; then
  goenv install $NEW_GO_VERSION
fi

goenv global $NEW_GO_VERSION
goenv rehash

if [[ ($NEW_NODE_VERSION != $NODE_VERSION && ! $(nodenv versions | grep "[- ]$NEW_NODE_VERSION")) || ! $(which node) =~ anyenv ]]; then
  nodenv install $NEW_NODE_VERSION
fi

nodenv global $NEW_NODE_VERSION
nodenv rehash

if [[ ($NEW_SCALA_VERSION != $SCALA_VERSION && ! $(scalaenv versions | grep "[- ]$NEW_SCALA_VERSION")) || ! $(which scala) =~ anyenv ]]; then
  scalaenv install $NEW_SCALA_VERSION
fi

scalaenv global $NEW_SCALA_VERSION
scalaenv rehash

if [[ ($NEW_SBT_VERSION != $SBT_VERSION && ! $(sbtenv versions | grep "[- ]$NEW_SBT_VERSION")) || ! $(which sbt) =~ anyenv ]]; then
  sbtenv install $NEW_SBT_VERSION
fi

sbtenv global $NEW_SBT_VERSION
sbtenv rehash

echo
printf "after versions:\n"
anyenv version
echo
anyenv versions
echo

printf "complete"

exit 0
