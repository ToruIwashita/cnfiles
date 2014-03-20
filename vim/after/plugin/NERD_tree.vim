"" FILE: NERD_tree.vim
let s:cpo_save = &cpo
set cpo&vim

noremap <C-w><C-w> :NERDTreeToggle<CR>
" 引数なしVim実行時にNERDTree
if has('vim_starting') && expand("%:p") == ""
  autocmd VimEnter * NERDTree
endif

let &cpo = s:cpo_save
unlet s:cpo_save
