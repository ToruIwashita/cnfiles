"" FILE: signature.vim
let s:cpo_save = &cpo
set cpo&vim

" 次のマークへジャンプ
map <C-e>] ]`
map <C-e><C-]> ]`
" 前のマークへジャンプ
map <C-e>[ [`
map <C-e><C-[> [`

let &cpo = s:cpo_save
unlet s:cpo_save
