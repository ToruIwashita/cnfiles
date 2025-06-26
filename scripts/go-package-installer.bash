#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which go) =~ asdf ]]; then
  printf "there is no go installed with asdf\n"
  exit 1
fi

export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

# check GOROOT
if [[ ! $GOROOT =~ asdf ]]; then
  printf "$GOROOT does not contain .asdf/\n"
  exit 1
fi

# check GOPATH
if [[ ! $GOPATH =~ asdf ]]; then
  printf "$GOPATH does not contain .asdf/\n"
  exit 1
fi

# create $GOPATH
if [[ -d $GOPATH ]]; then
  printf "\e[32m$GOPATH dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $GOPATH\e[0m\n"
  mkdir -p $GOPATH
fi

# create $GOPATH/bin
if [[ -d $GOPATH/bin ]]; then
  printf "\e[32m$GOPATH/bin dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $GOPATH/bin\e[0m\n"
  mkdir -p $GOPATH/bin
fi

export PATH="$PATH:$GOPATH/bin"

echo
printf "go: $(go version)\n"

echo
printf "\e[32mgo install github.com/mattn/longcat@latest\e[0m\n"
go install github.com/mattn/longcat@latest

printf "\e[32mgo install github.com/x-motemen/ghq@latest\e[0m\n"
go install github.com/x-motemen/ghq@latest

printf "\e[32mgo install github.com/skanehira/gtran@latest\e[0m\n"
go install github.com/skanehira/gtran@latest

printf "\e[32mgo install github.com/x-motemen/gore/cmd/gore@latest\e[0m\n"
go install github.com/x-motemen/gore/cmd/gore@latest

printf "\e[32mgo install github.com/go-delve/delve/cmd/dlv@latest\e[0m\n"
go install github.com/go-delve/delve/cmd/dlv@latest

printf "\e[32mgo install github.com/direnv/direnv@latest\e[0m\n"
go install github.com/direnv/direnv@latest

printf "\e[32mgo install github.com/peco/peco/cmd/peco@latest\e[0m\n"
go install github.com/peco/peco/cmd/peco@latest

asdf reshim golang

echo
printf "complete\n"

exit 0
