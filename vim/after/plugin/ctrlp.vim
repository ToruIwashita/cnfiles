"" FILE: ctrlp.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" (config.plugin.vim にも設定あり)

" カレントバッファの変更箇所を表示し,選択された位置にジャンプする
nnoremap __ :<C-u>CtrlPChangeAll<CR>
" リストされているバッファ全ての変更履歴を表示し,選択された位置にジャンプする
nnoremap <C-_><C-_> :<C-u>CtrlPChange<CR>
" リストされているバッファを表示し,選択されたバッファに移動する
nnoremap <C-s>; :<C-u>CtrlPBuffer<CR>
" tags ファイルの項目を表示し,選択された項目の位置へジャンプする
nnoremap <C-s>h :<C-u>CtrlPTag<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
