"" FILE: debugger.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

augroup local_debugger
  autocmd!
  autocmd VimEnter * DebuggerOn
augroup END

cnorea dh DebugHelp

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
