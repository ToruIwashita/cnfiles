"" FILE: window_closer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap <leader>l :<C-u>CloseRightWin<CR>
noremap <leader>h :<C-u>CloseLeftWin<CR>
noremap <leader><C-n> :<C-u>CloseDownWin<CR>
noremap <leader><C-p> :<C-u>CloseUpWin<CR>

" quickfix,loclist,preview閉じる
noremap <C-w><C-w> :<C-u>CloseMisWin<CR>

" ファイル保存,閉じる
noremap <C-o> :<C-u>w<CR>
noremap <leader>o :<C-u>wa<CR>
noremap <leader>f :<C-u>CloseMisWin<CR>:<C-u>q<CR>
noremap <leader>w :<C-u>w<CR>:<C-u>CloseMisWin<CR>:<C-u>q<CR>
noremap <leader>x :<C-u>wa<CR>:<C-u>qa<CR>

" 現在のウィンドウを閉じる
noremap <C-w>x <NOP>
noremap <C-w>x :<C-u>CloseMisWin<CR>:<C-u>close<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
