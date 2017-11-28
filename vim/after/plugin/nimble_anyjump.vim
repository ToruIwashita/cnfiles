"" FILE: nimble_anyjump.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" ジャンプ後の表示方法
let g:nimble_anyjump_output_style = 'vertical'
" ジャンプ後のカーソル画面位置
let g:nimble_anyjump_after_jump = 'zz'

function! s:nimble_anyjump_to_new_tab()
  let s:current_output_style = g:nimble_anyjump_output_style
  let g:nimble_anyjump_output_style = 'tabnew'

  NimbleTag

  let g:nimble_anyjump_output_style = s:current_output_style
endfunction

function! s:nimble_anyjump_range_to_new_tab()
  let s:current_output_style = g:nimble_anyjump_output_style
  let g:nimble_anyjump_output_style = 'tabnew'

  NimbleTagRange

  let g:nimble_anyjump_output_style = s:current_output_style
endfunction

command! NimbleAnyjumpToNewTab call s:nimble_anyjump_to_new_tab()
command! NimbleAnyjumpRangeToNewTab call s:nimble_anyjump_range_to_new_tab()

" tag直接入力
nnoremap <C-s>h :<C-u>tselect<SPACE>

" カーソル直下の文字列でtagジャンプ
noremap <C-s>l :<C-u>NimbleAnyjump<CR>
noremap <C-s>L :<C-u>NimbleAnyjumpToNewTab<CR>
noremap <C-s><C-l> :<C-u>NimbleTAnyjump<CR>

" 選択範囲の文字列でtagジャンプ
vnoremap <C-s>l :<C-u>NimbleAnyjumpRange<CR>
vnoremap <C-s>L :<C-u>NimbleAnyjumpRangeToNewTab<CR>
vnoremap <C-s><C-l> :<C-u>NimbleTAnyjumpRange<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
