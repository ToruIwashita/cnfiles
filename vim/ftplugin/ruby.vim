"" FILE: ruby.vim

set encoding=utf-8
scriptencoding utf-8

if exists('b:did_cnfiles_ruby_ftplugin')
  finish
endif
let b:did_cnfiles_ruby_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:yank_namespace(line_start, line_end) abort
  let l:lines = getline(a:line_start, a:line_end)
  let l:names = []

  for l:line in l:lines
    " module Name または class Name < Parent の形式をマッチ
    let l:matched = matchlist(l:line, '^\s*\(module\|class\)\s\+\(\w\+\)')
    if !empty(l:matched)
      call add(l:names, l:matched[2])
    endif
  endfor

  if empty(l:names)
    echohl WarningMsg | echo 'No module or class found in selection' | echohl None
    return
  endif

  let l:qualified_name = join(l:names, '::')
  let @" = l:qualified_name

  echo 'Yank: ' . l:qualified_name
endf

fun! s:remove_binding_irb() abort
  let l:save_cursor = getpos('.')

  " バッファ全体でbinding.irbのみの行を検索して削除
  try
    silent! execute 'g/^\s*binding\.irb\s*$/d'
    redraw
    echo 'Removed `binding.irb` lines from buffer'
  catch /E486:/
    " パターンが見つからない場合
    redraw
    echo '`binding.irb` lines not found in buffer'
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

command! -buffer -range YankNamespace call s:yank_namespace(<line1>, <line2>)
command! -buffer RemoveBindingIrb call s:remove_binding_irb()
command! -buffer RemoveCurrentMarker call s:remove_current_marker()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
