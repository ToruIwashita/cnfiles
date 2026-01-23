"" FILE: markdown.vim

set encoding=utf-8
scriptencoding utf-8

if exists('b:did_cnfiles_markdown_ftplugin')
  finish
endif
let b:did_cnfiles_markdown_ftplugin = 1

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" 末尾に半角スペース追加はデフォルトOFF
let g:add_md_space_enabled = 0

fun! markdown#add_md_space_enabled() abort
  return g:add_md_space_enabled
endf

" lightline.vim依存のコード
fun! s:add_md_space_toggle() abort
  if g:add_md_space_enabled
    let g:add_md_space_enabled = 0
  else
    let g:add_md_space_enabled = 1
  endif

  call lightline#update()
endf

fun! s:wrap_with_fence(...) range
  let l:opening_fence = a:0 ? '```' . a:1 : '```'
  let l:closing_fence = '```'

  " 選択範囲の開始行の1つ上の行の後に開始フェンスを挿入
  call append(a:firstline - 1, l:opening_fence)

  " 選択範囲の上に1行挿入されるため,元の最終行の位置は1つ下にずれる
  " そのためa:lastline + 1の後に終了フェンスを挿入する
  call append(a:lastline + 1, l:closing_fence)

  " カーソルを開始フェンスの行の先頭に移動する
  call cursor(a:firstline, 1)
endfunction

fun! s:add_md_space() abort
  if !g:add_md_space_enabled
    return 1
  endif

  execute 'mark Z'

  silent! execute '%s/\(^[^$].*[^ ]$\)/\1  /'

  silent! normal! `Z
  execute 'delmarks Z'
endfunction

fun! s:add_md_space_range() abort range
  if !g:add_md_space_enabled
    return 1
  endif

  silent! execute a:firstline.','.a:lastline.'s/\(^[^$].*[^ ]$\)/\1  /'
endfunction

augroup local_markdown
  autocmd!
  autocmd BufWritePre *.md call s:add_md_space()
augroup END

command! -buffer AddMdSpaceToggle call s:add_md_space_toggle()
command! -buffer -range -nargs=? WrapWithFence :<line1>,<line2>call s:wrap_with_fence(<f-args>)
command! -buffer -range MdFormat :<line1>,<line2>call s:add_md_space_range()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
