"" FILE: typescript.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

iabbrev <buffer> =d debugger;
iabbrev =f //<SPACE>TODO:
iabbrev #=f //<SPACE>TODO:
iabbrev =q //<SPACE>QUESTION:
iabbrev #=q //<SPACE>QUESTION:"

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
