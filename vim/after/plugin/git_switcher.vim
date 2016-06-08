"" FILE: git_switcher.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:gsw_autoload_session = 'confirm'
let g:gsw_switch_autostash = 1

" <C-s>プレフィックス
nnoremap <C-s>p :<C-u>GswPull<CR>
nnoremap <C-s>n :<C-u>GswFetch<CR>

" <C-w>プレフィックス
nnoremap <C-w><C-i> :<C-u>GswSave<CR>
nnoremap <C-w><C-r> :<C-u>GswLoad<CR>

" <C-g>プレフィックス
nnoremap <C-g>g :<C-u>Gsw<SPACE>
nnoremap <C-g><C-g> :<C-u>GswRemote<SPACE>
nnoremap <C-g>b :<C-u>GswBranch<CR>
nnoremap <C-g><C-b> :<C-u>GswBranchRemote<CR>
nnoremap <C-g>i :<C-u>GswSave<SPACE>
nnoremap <C-g>r :<C-u>GswLoad<SPACE>
nnoremap <C-s>@ :<C-u>GswClearState

let &cpo = s:cpo_save
unlet s:cpo_save
