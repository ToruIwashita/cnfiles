"" FILE: signature.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-e> <NOP>
" 次のマークへジャンプ
nnoremap <C-e>] ]`zz
nnoremap <C-e><C-]> ]`zz
" 前のマークへジャンプ
nnoremap <C-e>[ [`zz
nnoremap <C-e><C-[> [`zz

let &cpo = s:cpo_save
unlet s:cpo_save
