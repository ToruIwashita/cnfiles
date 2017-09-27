"" FILE: paste_yank.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" コマンドラインにヤンクした文字列をペースト
cnoremap <C-w>p <C-r>"

" 削除してから貼り付けを行う時に事前にヤンクした文字列をペースト
noremap <leader>p "0pb
noremap <leader>P "0P

" カーソル以降の文字とヤンクした単語を置換
nnoremap <silent> cp :<C-u>ChangeCursorWordToYankWithAdjustCursorPosition<CR>
nnoremap <silent> cP :<C-u>ChangeCursorWordToYank<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
