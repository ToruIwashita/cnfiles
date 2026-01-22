#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

curl -fsSL https://claude.ai/install.sh | bash

printf "\ncomplete\n"
exit 0
