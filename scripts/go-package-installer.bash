#!/usr/bin/env bash

source "$(cd "$(dirname "$_")"; pwd)/env.bash"
set -e

if [[ ! $(which go) =~ asdf ]]; then
  printf "there is no go installed with asdf\n"
  exit 1
fi

GOROOT=$(go env GOROOT)
GOPATH=$(go env GOPATH)
export GOROOT GOPATH

# check GOROOT
if [[ ! $GOROOT =~ asdf ]]; then
  printf "%s does not contain .asdf/\n" "$GOROOT"
  exit 1
fi

# check GOPATH
if [[ ! $GOPATH =~ asdf ]]; then
  printf "%s does not contain .asdf/\n" "$GOPATH"
  exit 1
fi

# create $GOPATH
if [[ -d $GOPATH ]]; then
  printf "\e[32m%s dir already exists\e[0m\n" "$GOPATH"
else
  printf "\e[31mmkdir %s\e[0m\n" "$GOPATH"
  mkdir -p "$GOPATH"
fi

# create $GOPATH/bin
if [[ -d $GOPATH/bin ]]; then
  printf "\e[32m%s/bin dir already exists\e[0m\n" "$GOPATH"
else
  printf "\e[31mmkdir %s/bin\e[0m\n" "$GOPATH"
  mkdir -p "$GOPATH/bin"
fi

export PATH="$PATH:$GOPATH/bin"

echo
printf "go: %s\n" "$(go version)"

echo
printf "\e[32mgo install github.com/mattn/longcat@latest\e[0m\n"
go install github.com/mattn/longcat@latest

printf "\e[32mgo install github.com/x-motemen/ghq@latest\e[0m\n"
go install github.com/x-motemen/ghq@latest

printf "\e[32mgo install github.com/x-motemen/gore/cmd/gore@latest\e[0m\n"
go install github.com/x-motemen/gore/cmd/gore@latest

printf "\e[32mgo install github.com/go-delve/delve/cmd/dlv@latest\e[0m\n"
go install github.com/go-delve/delve/cmd/dlv@latest

printf "\e[32mgo install github.com/direnv/direnv/v2@latest\e[0m\n"
go install github.com/direnv/direnv/v2@latest

printf "\e[32mgo install github.com/charmbracelet/glow/v2@latest\e[0m\n"
go install github.com/charmbracelet/glow/v2@latest

printf "\e[32mgo install github.com/peco/peco/cmd/peco@latest\e[0m\n"
go install github.com/peco/peco/cmd/peco@latest

asdf reshim golang

echo
printf "complete\n"

exit 0
