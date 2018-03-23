#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

echo $GOROOT
echo $GOPATH
curl https://glide.sh/get | sh

printf "\ncomplete\n"
exit 0
