"" FILE: debugger.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

cnorea dh DebugHelp

augroup local_debugger
  autocmd!
  autocmd VimEnter * DebuggerOn
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
