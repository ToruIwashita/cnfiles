"" FILE: signature.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-e> <NOP>
" 指定マークへ移動
noremap <C-e>e '
noremap <C-e><C-e> '
" 次のマークへジャンプ
nnoremap <silent> <C-e>n ]`zz
nnoremap <silent> <C-e><C-n> ]`zz
" 前のマークへジャンプ
nnoremap <silent> <C-e>p [`zz
nnoremap <silent> <C-e><C-p> [`zz

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
