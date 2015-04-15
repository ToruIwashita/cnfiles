"" FILE: signature.vim
let s:cpo_save = &cpo
set cpo&vim

" マーク関連の動作に使用するキーのデフォルトの動きを無効化
nnoremap <C-e> <NOP>
" 次のマークへジャンプ
nnoremap <C-e>] ]`
nnoremap <C-e><C-]> ]`
" 前のマークへジャンプ
nnoremap <C-e>[ [`
nnoremap <C-e><C-[> [`

let &cpo = s:cpo_save
unlet s:cpo_save
