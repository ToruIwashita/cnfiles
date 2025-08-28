"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" markdownはテキストの最大幅無し
setlocal textwidth=0
" オートインデント時の空白文字数(pluginで書き換えられてしまうため再設定)
setlocal shiftwidth=2
" <TAB>を含むファイルを開いた際,<TAB>を何文字の空白に変換するか(pluginで書き換えられてしまうため再設定)
setlocal tabstop=2
" キーボードで<TAB>を入力した際,<TAB>を何文字の空白に変換するか(pluginで書き換えられてしまうため再設定)
setlocal softtabstop=2

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

command! -range -nargs=? WrapWithFence :<line1>,<line2>call s:wrap_with_fence(<f-args>)

vnoremap <Leader>fr :WrapWithFence ruby<CR>
vnoremap <Leader>fb :WrapWithFence bash<CR>
vnoremap <Leader>fs :WrapWithFence sql<CR>
vnoremap <Leader>fp :WrapWithFence plantuml<CR>
vnoremap <Leader>ff :WrapWithFence<CR>

ab <buffer> =b <br/>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
