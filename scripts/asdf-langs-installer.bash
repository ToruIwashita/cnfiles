#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

DEFAULT_GO_VERSION=1.23.4
DEFAULT_JAVA_VERSION=temurin-24.0.1+9
DEFAULT_NODE_VERSION=22.15.1
DEFAULT_PYTHON3_VERSION=3.13.1
DEFAULT_RUBY_VERSION=3.3.6
DEFAULT_RUST_VERSION=1.86.0

USE_GO_VERSION=${USE_GO_VERSION:-$DEFAULT_GO_VERSION}
USE_JAVA_VERSION=${USE_JAVA_VERSION:-$DEFAULT_JAVA_VERSION}
USE_NODE_VERSION=${USE_NODE_VERSION:-$DEFAULT_NODE_VERSION}
USE_PYTHON3_VERSION=${USE_PYTHON3_VERSION:-$DEFAULT_PYTHON3_VERSION}
USE_RUBY_VERSION=${USE_RUBY_VERSION:-$DEFAULT_RUBY_VERSION}
USE_RUST_VERSION=${USE_RUST_VERSION:-$DEFAULT_RUST_VERSION}

printf "install plugins\n"
echo

asdf plugin add golang
asdf plugin add java
asdf plugin add nodejs
asdf plugin add python
asdf plugin add ruby
asdf plugin add rust

printf "\nbefore versions:\n"
echo

asdf list

echo

asdf install golang $USE_GO_VERSION
asdf set -u golang $USE_GO_VERSION
echo

asdf install java $USE_JAVA_VERSION
asdf set -u java $USE_JAVA_VERSION
echo

asdf install nodejs $USE_NODE_VERSION
asdf set -u nodejs $USE_NODE_VERSION
echo

asdf install python $USE_PYTHON3_VERSION
asdf set -u python $USE_PYTHON3_VERSION
echo

asdf install ruby $USE_RUBY_VERSION
asdf set -u ruby $USE_RUBY_VERSION
echo

asdf install rust $USE_RUST_VERSION
asdf set -u rust $USE_RUST_VERSION
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
