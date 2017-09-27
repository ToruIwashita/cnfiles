"" FILE: nimble_tag_jump.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" タグジャンプ後の表示方法
let g:nimble_tag_jump_output_style = 'vertical'
" タグジャンプ後のカーソル画面位置
let g:nimble_tag_jump_after_jump = 'zz'

function! s:nimble_tag_to_new_tab()
  let s:current_output_style = g:nimble_tag_jump_output_style
  let g:nimble_tag_jump_output_style = 'tabnew'

  NimbleTag

  let g:nimble_tag_jump_output_style = s:current_output_style
endfunction

function! s:nimble_tag_range_to_new_tab()
  let s:current_output_style = g:nimble_tag_jump_output_style
  let g:nimble_tag_jump_output_style = 'tabnew'

  NimbleTagRange

  let g:nimble_tag_jump_output_style = s:current_output_style
endfunction

command! NimbleTagToNewTab call s:nimble_tag_to_new_tab()
command! NimbleTagRangeToNewTab call s:nimble_tag_range_to_new_tab()

" tag直接入力
nnoremap <C-s>h :<C-u>tselect<SPACE>

" カーソル直下の文字列でtagジャンプ
noremap <C-s>l :<C-u>NimbleTag<CR>
noremap <C-s>L :<C-u>NimbleTagToNewTab<CR>
noremap <C-s><C-l> :<C-u>NimbleTjump<CR>

" 選択範囲の文字列でtagジャンプ
vnoremap <C-s>l :<C-u>NimbleTagRange<CR>
vnoremap <C-s>L :<C-u>NimbleTagRangeToNewTab<CR>
vnoremap <C-s><C-l> :<C-u>NimbleTjumpRange<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
