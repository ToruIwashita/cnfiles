"" FILE: signature.vim
let s:cpo_save = &cpo
set cpo&vim

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-e> <NOP>
" 次のマークへジャンプ
nnoremap <C-e>] ]`zt
nnoremap <C-e><C-]> ]`zt
" 前のマークへジャンプ
nnoremap <C-e>[ [`zt
nnoremap <C-e><C-[> [`zt

let &cpo = s:cpo_save
unlet s:cpo_save
