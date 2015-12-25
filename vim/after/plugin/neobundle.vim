"" FILE: neobundle.vim
let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-w>I :<C-u>NeoBundleInstall<CR>
nnoremap <C-w>U :<C-u>NeoBundleUpdate<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
