"" FILE: window_closer.vim
let s:cpo_save = &cpo
set cpo&vim

" 右のウィンドウを閉じる
noremap <silent> <leader>l :<C-u>CloseRightWin<CR>
noremap <silent> <leader>h :<C-u>CloseLeftWin<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
