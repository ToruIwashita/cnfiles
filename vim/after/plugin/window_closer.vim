"" FILE: window_closer.vim
let s:cpo_save = &cpo
set cpo&vim

" 右のウィンドウを閉じる
noremap <leader>w :<C-u>WinClose 'l'<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
