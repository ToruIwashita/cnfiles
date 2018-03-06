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

" 現在のウィンドウで保存
noremap <C-o> :<C-u>w<CR>
" 現在のウィンドウで保存して閉じる(最後のウィンドウでも閉じる)
noremap <leader>w :<C-u>w<CR>:<C-u>CloseMisWin<CR>:<C-u>q<CR>
" バッファ全てを保存
noremap <leader>o :<C-u>wa<CR>
" 現在のウィンドウを閉じる(最後のウィンドウでも閉じる)
noremap <leader>e :<C-u>CloseMisWin<CR>:<C-u>q<CR>
" 現在のウィンドウを閉じる(最後のウィンドウだった場合は閉じない)
noremap <C-w>x :<C-u>CloseMisWin<CR>:<C-u>close<CR>
" バッファ全てを保存して全て閉じる
noremap <leader>x :<C-u>wa<CR>:<C-u>qa<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
