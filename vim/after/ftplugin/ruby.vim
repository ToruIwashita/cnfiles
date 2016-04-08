"" FILE: ruby.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" !,?を区切り文字としない
setlocal iskeyword+=!,?

" RubyCursorIdentifier()とタブ移動のmap競合を解消
silent! nunmap <buffer> <C-w>]
silent! nunmap <buffer> <C-w><C-]>
" タグ移動のmapを解除
silent! nunmap <buffer> <C-]>

ab <buffer> =p binding.pry
ab <buffer> =8 # coding: utf-8
ab <buffer> =t , current: true
ab <buffer> =c context "current", current: true do
ab <buffer> =d Rails.logger.debug(<<EOS)
  \<ENTER><ESC>i-
  \<ENTER><ESC>i-
  \<ENTER><ESC>i------------------ debug info ------------------
  \<ENTER><ESC>i
  \<ENTER><ESC>i------------------------------------------------
  \<ENTER><ESC>i-
  \<ENTER><ESC>i-
  \<ENTER><ESC>iEOS<ENTER><ESC>

let &cpo = s:cpo_save
unlet s:cpo_save
