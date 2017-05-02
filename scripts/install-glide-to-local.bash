#!/usr/bin/env bash

source ${${(%):-%N}:A:h}/env.bash
set -e

curl https://glide.sh/get | sh

printf "\ncomplete\n"
exit 0
