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

" ウィンドウの操作(似た設定がgitgutter.vimにもある)
" 現在のウィンドウで保存して閉じる(最後のウィンドウでも閉じる)
noremap <leader>w :<C-u>w<CR>:<C-u>CloseMisWin<CR>:<C-u>q<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
