#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

if [[ ! $(which go)} =~ anyenv ]]; then
  printf "there is no go installed with anyenv\n"
  exit 1
fi

export GOROOT=$(go env GOROOT)
export GOPATH=$(go env GOPATH)

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

printf "go: $(go version)\n"

echo
echo 'go install github.com/jackc/sqlfmt/cmd/sqlfmt@latest'
go install github.com/jackc/sqlfmt/cmd/sqlfmt@latest
echo 'go install github.com/mattn/longcat@latest'
go install github.com/mattn/longcat@latest
echo 'go install github.com/x-motemen/ghq@latest'
go install github.com/x-motemen/ghq@latest
echo 'go install github.com/skanehira/gtran@latest'
go install github.com/skanehira/gtran@latest

echo
printf "complete\n"

exit 0
