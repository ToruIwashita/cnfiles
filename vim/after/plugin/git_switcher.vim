"" FILE: git_switcher.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:gsw_autoload_session = 'confirm'
let g:gsw_save_session_confirm = 'no'
let g:gsw_load_session_confirm = 'yes'
let g:gsw_switch_prev_confirm = 'yes'

" <C-s>プレフィックス
nnoremap <C-s>p :<C-u>GswPull<CR>
nnoremap <C-s>n :<C-u>GswFetch<CR>
nnoremap <C-s>@ :<C-u>GswClearState

" <C-w>プレフィックス
nnoremap <C-w><C-o> :<C-u>GswSave<CR>
nnoremap <C-w>o :<C-u>GswSave<SPACE>
nnoremap <C-w><C-r> :<C-u>GswLoad<CR>
nnoremap <C-w>r :<C-u>GswLoad<SPACE>

" <C-g>プレフィックス
nnoremap <C-g>g :<C-u>Gsw<SPACE>
nnoremap <C-g><C-g> :<C-u>GswRemote<SPACE>
nnoremap <C-g>m :<C-u>GswMove<SPACE>
nnoremap <C-g>_ :<C-u>GswPrev<CR>
nnoremap <C-g>b :<C-u>GswBranch<CR>
nnoremap <C-g><C-b> :<C-u>GswBranchRemote<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
