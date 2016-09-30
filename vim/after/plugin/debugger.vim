"" FILE: debugger.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

augroup local_debugger
  autocmd!
  autocmd VimEnter * DebuggerOn
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
