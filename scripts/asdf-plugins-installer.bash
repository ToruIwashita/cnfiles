#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

DEFAULT_RUBY_VERSION=3.3.6
DEFAULT_PYTHON2_VERSION=2.7.18
DEFAULT_PYTHON3_VERSION=3.13.1
DEFAULT_GO_VERSION=1.23.4
DEFAULT_NODE_VERSION=20.18.1

USE_RUBY_VERSION=${USE_RUBY_VERSION:-$DEFAULT_RUBY_VERSION}
USE_PYTHON2_VERSION=${USE_PYTHON2_VERSION:-$DEFAULT_PYTHON2_VERSION}
USE_PYTHON3_VERSION=${USE_PYTHON3_VERSION:-$DEFAULT_PYTHON3_VERSION}
USE_GO_VERSION=${USE_GO_VERSION:-$DEFAULT_GO_VERSION}
USE_NODE_VERSION=${USE_NODE_VERSION:-$DEFAULT_NODE_VERSION}

printf "install plugins\n"
echo

asdf plugin add ruby
asdf plugin add python
asdf plugin add golang
asdf plugin add nodejs

printf "\nbefore versions:\n"
echo

asdf list

echo

asdf install ruby $USE_RUBY_VERSION
asdf global ruby $USE_RUBY_VERSION

asdf install python $USE_PYTHON2_VERSION
asdf install python $USE_PYTHON3_VERSION
asdf global python $USE_PYTHON3_VERSION $USE_PYTHON2_VERSION

asdf install golang $USE_GO_VERSION
asdf global golang $USE_GO_VERSION

asdf install nodejs $USE_NODE_VERSION
asdf global nodejs $USE_NODE_VERSION

if [[ $(which node) =~ asdf ]]; then
  corepack enable
  asdf reshim nodejs
fi

printf "\nafter versions:\n"
echo

asdf list

echo

asdf current

printf "\ncomplete\n"

exit 0
