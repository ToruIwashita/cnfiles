"" FILE: ruby.vim
let s:cpo_save = &cpo
set cpo&vim

" RubyCursorIdentifier()とタブ移動のmap競合を解消
silent! nunmap <buffer> <C-w>]
silent! nunmap <buffer> <C-w><C-]>

ab <buffer> =p binding.pry
ab <buffer> =8 # coding: utf-8
ab <buffer> =c , current: true
ab <buffer> =d Rails.logger.debug(<<EOS)
  \<ENTER><ESC>i-
  \<ENTER><ESC>i-
  \<ENTER><ESC>i------------------ debug info ------------------
  \<ENTER><ESC>i
  \<ENTER><ESC>i------------------------------------------------
  \<ENTER><ESC>i-
  \<ENTER><ESC>i-
  \<ENTER><ESC>iEOS<ENTER><ESC>

" !,?を区切り文字としない
autocmd FileType ruby setlocal iskeyword+=!,?

let &cpo = s:cpo_save
unlet s:cpo_save
