"" FILE: qfixgrep.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

command! -nargs=* -bang Vimgrep call qfixgrep#QFixCmdGrep('Vimgrep', <q-args>)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
