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
  mkdir $GOPATH
fi

# create $GOPATH/bin
if [[ -d $GOPATH/bin ]]; then
  printf "\e[32m$GOPATH/bin dir already exists\e[0m\n"
else
  printf "\e[31mmkdir $GOPATH/bin\e[0m\n"
  mkdir $GOPATH/bin
fi

export PATH="$PATH:$GOPATH/bin"

printf "go: $(go version)\n"

echo
echo 'go get -u github.com/jackc/sqlfmt/...'
go get -u github.com/jackc/sqlfmt/...
echo 'go get -u github.com/mattn/longcat'
go get -u github.com/mattn/longcat
echo 'go get -u github.com/motemen/ghq'
go get -u github.com/motemen/ghq
echo 'go get -u github.com/skanehira/gtran'
go get -u github.com/skanehira/gtran

echo
printf "complete\n"

exit 0
