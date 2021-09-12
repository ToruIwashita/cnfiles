"" FILE: nimble_anyjump.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" ジャンプ後の表示方法
let g:nimble_anyjump_output_style = 'vertical'
" ジャンプ後のカーソル画面位置
let g:nimble_anyjump_after_jump = 'zz'

function! s:nimble_anyjump_to_new_tab() abort
  let s:current_output_style = g:nimble_anyjump_output_style
  let g:nimble_anyjump_output_style = 'tabnew'

  NimbleAnyjump

  let g:nimble_anyjump_output_style = s:current_output_style
endfunction

function! s:nimble_anyjump_range_to_new_tab() abort
  let s:current_output_style = g:nimble_anyjump_output_style
  let g:nimble_anyjump_output_style = 'tabnew'

  NimbleAnyjumpRange

  let g:nimble_anyjump_output_style = s:current_output_style
endfunction

command! NimbleAnyjumpToNewTab call s:nimble_anyjump_to_new_tab()
command! NimbleAnyjumpRangeToNewTab call s:nimble_anyjump_range_to_new_tab()

" カーソル直下の文字列でtagジャンプ
nmap <C-s>l <Plug>(nimble-anyjump)
nmap <C-s><C-l> <Plug>(nimble-t-anyjump)
noremap <C-s>L :<C-u>NimbleAnyjumpToNewTab<CR>

" 選択範囲の文字列でtagジャンプ
vmap <C-s>l <Plug>(nimble-anyjump-range)
vmap <C-s><C-l> <Plug>(nimble-t-anyjump-range)
vnoremap <C-s>L :<C-u>NimbleAnyjumpRangeToNewTab<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
