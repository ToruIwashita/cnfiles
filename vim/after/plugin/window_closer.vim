"" FILE: window_closer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

noremap <leader>l :<C-u>CloseRightWin<CR>
noremap <leader>h :<C-u>CloseLeftWin<CR>
noremap <leader><C-n> :<C-u>CloseDownWin<CR>
noremap <leader><C-p> :<C-u>CloseUpWin<CR>

" ウィンドウの操作(似た設定がgitgutter.vimにもある)
" 現在のウィンドウを閉じる(最後のウィンドウでも閉じる)
noremap <leader>w :<C-u>silent! w<CR>:CloseMisWin<CR>:q<CR>

" CtrlSFのwindowも閉じる,以下はctrlsf.vim依存のコード
" CtrlSF window,quickfix,loclist,previewを閉じる
noremap <C-w><C-w> :<C-u>CtrlSFClose<CR>:CloseMisWin<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
