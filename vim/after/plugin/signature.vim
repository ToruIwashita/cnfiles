"" FILE: signature.vim
let s:cpo_save = &cpo
set cpo&vim

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-e> <NOP>
" 次のマークへジャンプ
nnoremap <C-e>] ]`zt5<C-y>
nnoremap <C-e><C-]> ]`zt5<C-y>
" 前のマークへジャンプ
nnoremap <C-e>[ [`zt5<C-y>
nnoremap <C-e><C-[> [`zt5<C-y>

let &cpo = s:cpo_save
unlet s:cpo_save
