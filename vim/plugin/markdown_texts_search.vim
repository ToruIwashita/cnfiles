"" FILE: markdown_texts_search.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:markdown_texts_search(...)
  cexpr system("ag 辞書 ~/markdown_texts/")

  if a:0 >= 1
    let l:search_word = a:1
  else
    let l:search_word = expand('<cword>')
  endif

  tabnew
  cexpr system('ag '.l:search_word.' ~/markdown_texts/')
  cwindow
endfunction

function! s:markdown_texts_search_range() range
  let l:unnamed_register = @@
  silent! normal! gvy
  let l:selected_range = @@
  let @@ = l:unnamed_register

  if l:selected_range =~# "'"
    let l:escaped_selected_range = '"'.escape(l:selected_range, ' \"').'"'
  elseif l:selected_range =~# '[ \"]'
    let l:escaped_selected_range = string(l:selected_range)
  else
    let l:escaped_selected_range = l:selected_range
  endif

  tabnew
  cexpr system('ag '.l:escaped_selected_range.' ~/markdown_texts/')
  cwindow
endfunction

command -nargs=? MarkdownTextsSearch call s:markdown_texts_search(<f-args>)
command -range MarkdownTextsSearchRange call s:markdown_texts_search_range()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
