"" FILE: ruby.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" !,?を区切り文字としない
setlocal iskeyword+=!,?

" RubyCursorIdentifier()とタブ移動のmap競合を解消
silent! nunmap <buffer> <C-w>]
silent! nunmap <buffer> <C-w><C-]>
" タグ移動のmapを解除
silent! nunmap <buffer> <C-]>

ab <buffer> =a , :aggregate_failures
ab <buffer> =c context "current", current: true do
ab <buffer> =f # frozen_string_literal: true
ab <buffer> =d binding.pry
ab <buffer> =r require 'pry'
ab <buffer> =t , current: true

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
