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

fun! s:remove_binding_pry() abort
  let l:save_cursor = getpos('.')

  " バッファ全体でbinding.pryのみの行を検索して削除
  try
    silent! execute 'g/^\s*binding\.pry\s*$/d'
    redraw
    echo 'Removed `binding.pry` lines from buffer'
  catch /E486:/
    " パターンが見つからない場合
    redraw
    echo '`binding.pry` lines not found in buffer'
  endtry

  " カーソル位置を復元
  call setpos('.', l:save_cursor)
endf

fun! s:remove_current_marker() abort
  let l:save_cursor = getpos('.')

  " バッファ全体で`, :current`を検索して削除
  try
    execute '%s/, :current //ge'
    echo 'Removed `, :current ` from buffer'
  catch /E486:/
    " パターンが見つからない場合
    echo '`, :current ` not found in buffer'
  endtry

  " カーソル位置を復元
  call setpos('.', l:save_cursor)
endf

command! RemoveBindingPry call s:remove_binding_pry()
command! RemoveCurrentMarker call s:remove_current_marker()

nnoremap <buffer> =d :<C-u>RemoveBindingPry<CR>
nnoremap <buffer> =t :<C-u>RemoveCurrentMarker<CR>

ab <buffer> =a , :aggregate_failures
ab <buffer> =c context "current", :current do
ab <buffer> =d binding.pry
ab <buffer> =f # frozen_string_literal: true
ab <buffer> =t , :current

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
