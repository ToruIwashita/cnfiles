#!/usr/bin/env bash

source $(cd $(dirname $_);pwd)/env.bash
set -e

go get github.com/tools/godep
go get github.com/google/btree
go get github.com/jessevdk/go-flags
go get github.com/mattn/go-runewidth
go get github.com/nsf/termbox-go
go get github.com/lestrrat/go-pdebug

go get -u all

printf "\ncomplete\n"
exit 0
