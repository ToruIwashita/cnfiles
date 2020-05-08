#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

ANYENV_ROOT=~/.anyenv

export PATH="$PATH:$ANYENV_ROOT/bin"

DEFAULT_RUBY_VERSION=2.6.6
DEFAULT_PYTHON3_VERSION=3.8.1
DEFAULT_PYTHON2_VERSION=2.7.17
DEFAULT_LUA_VERSION='luajit-2.0.5'
DEFAULT_GO_VERSION=1.13.4
DEFAULT_NODE_VERSION=10.20.1
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

RBENV_SHIMS=$ANYENV_ROOT/envs/rbenv/shims/.rbenv-shim
PYENV_SHIMS=$ANYENV_ROOT/envs/pyenv/shims/.pyenv-shim
LUAENV_SHIMS=$ANYENV_ROOT/envs/luaenv/shims/.luaenv-shim
GOENV_SHIMS=$ANYENV_ROOT/envs/goenv/shims/.goenv-shim
NODENV_SHIMS=$ANYENV_ROOT/envs/nodenv/shims/.nodenv-shim
SCALAENV_SHIMS=$ANYENV_ROOT/envs/scalaenv/shims/.scalaenv-shim
SBTENV_SHIMS=$ANYENV_ROOT/envs/sbtenv/shims/.sbtenv-shim

eval "$(anyenv init -)" || true

printf "before versions:\n"
echo
anyenv versions
echo

[[ ! $(which rbenv) ]] && anyenv install rbenv
[[ ! $(which pyenv) ]] && anyenv install pyenv
[[ ! $(which luaenv) ]] && anyenv install luaenv
[[ ! $(which goenv) ]] && anyenv install goenv
[[ ! $(which nodenv) ]] && anyenv install nodenv
[[ ! $(which scalaenv) ]] && anyenv install scalaenv
[[ ! $(which sbtenv) ]] && anyenv install sbtenv

if [[ ! $(which ruby) =~ anyenv || ! $(rbenv versions | grep "[- ]$USE_RUBY_VERSION") ]]; then
  RUBY_CONFIGURE_OPTS='--enable-shared' rbenv install $USE_RUBY_VERSION
fi

[[ -f $RBENV_SHIMS ]] && rm $RBENV_SHIMS

rbenv global $USE_RUBY_VERSION
rbenv rehash

if [[ ! $(which python3) =~ anyenv || ! $(pyenv versions | grep "[- ]$USE_PYTHON3_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' pyenv install $USE_PYTHON3_VERSION
fi

if [[ ! $(which python2) =~ anyenv || ! $(pyenv versions | grep "[- ]$USE_PYTHON2_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' pyenv install $USE_PYTHON2_VERSION
fi

[[ -f $PYENV_SHIMS ]] && rm $PYENV_SHIMS

pyenv global $USE_PYTHON3_VERSION $USE_PYTHON2_VERSION
pyenv rehash

if [[ ! $(which lua) =~ anyenv || ! $(luaenv versions | grep "[- ]$USE_LUA_VERSION") ]]; then
  # LuaJITのインストールはMacの10.15以上で失敗するためMACOSX_DEPLOYMENT_TARGETを指定
  MACOSX_DEPLOYMENT_TARGET=10.14 CONFIGURE_OPTS='--enable-shared' luaenv install $USE_LUA_VERSION
fi

[[ -f $LUAENV_SHIMS ]] && rm $LUAENV_SHIMS

luaenv global $USE_LUA_VERSION
luaenv rehash

if [[ ! $(which go) =~ anyenv || ! $(goenv versions | grep "[- ]$USE_GO_VERSION") ]]; then
  CONFIGURE_OPTS='--enable-shared' goenv install $USE_GO_VERSION
fi

[[ -f $GOENV_SHIMS ]] && rm $GOENV_SHIMS

goenv global $USE_GO_VERSION
goenv rehash

if [[ ! $(which node) =~ anyenv || ! $(nodenv versions | grep "[- ]$USE_NODE_VERSION") ]]; then
  nodenv install $USE_NODE_VERSION
fi

[[ -f $NODENV_SHIMS ]] && rm $NODENV_SHIMS

nodenv global $USE_NODE_VERSION
nodenv rehash

if [[ ! $(which scala) =~ anyenv || ! $(scalaenv versions | grep "[- ]$USE_SCALA_VERSION") ]]; then
  scalaenv install $USE_SCALA_VERSION
fi

[[ -f $SCALAENV_SHIMS ]] && rm $SCALAENV_SHIMS

scalaenv global $USE_SCALA_VERSION
scalaenv rehash

if [[ ! $(which sbt) =~ anyenv || ! $(sbtenv versions | grep "[- ]$USE_SBT_VERSION") ]]; then
  sbtenv install $USE_SBT_VERSION
fi

[[ -f $SBTENV_SHIMS ]] && rm $SBTENV_SHIMS

sbtenv global $USE_SBT_VERSION
sbtenv rehash

echo
printf "after versions:\n"
anyenv versions
echo

printf "complete"

exit 0
