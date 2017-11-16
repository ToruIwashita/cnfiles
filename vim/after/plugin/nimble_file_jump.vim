"" FILE: nimble_file_jump.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" ファイルジャンプ後の表示方法
let g:nimble_file_jump_output_style = 'vertical'
" ファイルジャンプ後のカーソル画面位置
let g:nimble_file_jump_after_jump = 'zz'

function! s:nimble_file_to_new_tab()
  let s:current_output_style = g:nimble_file_jump_output_style
  let g:nimble_file_jump_output_style = 'tabnew'

  NimbleFile

  let g:nimble_file_jump_output_style = s:current_output_style
endfunction

command! NimbleFileToNewTab call s:nimble_file_to_new_tab()

" カーソル直下のファイルパスジャンプ
" noremap <C-f>f :<C-u>NimbleFile<CR>
" noremap <C-f>F :<C-u>NimbleFileToNewTab<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
