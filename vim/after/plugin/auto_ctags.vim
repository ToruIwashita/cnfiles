"" FILE: auto_ctags.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" (config.plugin.vim にも設定あり)

nnoremap <leader>ct :<C-u>Ctags<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
