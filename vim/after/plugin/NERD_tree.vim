"" FILE: NERD_tree.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-w>w :<C-u>NERDTreeToggle<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
