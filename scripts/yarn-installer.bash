#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

DEFAULT_YARN_VERSION=1.22.4

USE_YARN_VERSION=${USE_YARN_VERSION:-$DEFAULT_YARN_VERSION}

curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version $USE_YARN_VERSION

printf "\ncomplete\n"
exit 0
