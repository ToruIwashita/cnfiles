"" FILE: signature.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" 指定マークへ移動
noremap <leader>e '

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-e> <NOP>
" 次のマークへジャンプ
nnoremap <C-e>] ]`zz
nnoremap <C-e><C-]> ]`zz
" 前のマークへジャンプ
nnoremap <C-e>[ [`zz
nnoremap <C-e><C-[> [`zz

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
