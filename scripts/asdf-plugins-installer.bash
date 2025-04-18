#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

DEFAULT_GO_VERSION=1.23.4
DEFAULT_NODE_VERSION=22.12.0
DEFAULT_PYTHON3_VERSION=3.13.1
DEFAULT_RUBY_VERSION=3.3.6
DEFAULT_RUST_VERSION=1.86.0

USE_GO_VERSION=${USE_GO_VERSION:-$DEFAULT_GO_VERSION}
USE_NODE_VERSION=${USE_NODE_VERSION:-$DEFAULT_NODE_VERSION}
USE_PYTHON3_VERSION=${USE_PYTHON3_VERSION:-$DEFAULT_PYTHON3_VERSION}
USE_RUBY_VERSION=${USE_RUBY_VERSION:-$DEFAULT_RUBY_VERSION}
USE_RUST_VERSION=${USE_RUST_VERSION:-$DEFAULT_RUST_VERSION}

printf "install plugins\n"
echo

asdf plugin add golang
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
asdf plugin add rust

printf "\nbefore versions:\n"
echo

asdf list

echo

asdf install golang $USE_GO_VERSION
asdf reshim golang $USE_GO_VERSION
echo

asdf install nodejs $USE_NODE_VERSION
asdf reshim nodejs $USE_NODE_VERSION
echo

asdf install python $USE_PYTHON3_VERSION
asdf reshim python $USE_PYTHON3_VERSION
echo

asdf install ruby $USE_RUBY_VERSION
asdf reshim ruby $USE_RUBY_VERSION
echo

asdf install rust $USE_RUST_VERSION
asdf reshim rust $USE_RUST_VERSION
echo

if [[ $(which node) =~ asdf ]]; then
  corepack enable
fi

printf "\nafter versions:\n"
echo

asdf list

echo

asdf current

printf "\ncomplete\n"

exit 0
