"" FILE: signature.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-t> <NOP>
" 指定マークへ移動
noremap <C-t>t '
noremap <C-t><C-t> '
" 次のマークへジャンプ
nnoremap <C-t>] ]`zz
nnoremap <C-t><C-]> ]`zz
" 前のマークへジャンプ
nnoremap <C-t>[ [`zz
nnoremap <C-t><C-[> [`zz

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
