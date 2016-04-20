"" FILE: git_switcher.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:gsw_session_autoload = 'yes'
let g:gsw_switch_autostash = 1

nnoremap <C-s>i :<C-u>GswSave<SPACE>
nnoremap <C-s>r :<C-u>GswLoad<SPACE>
nnoremap <C-s>g :<C-u>Gsw<SPACE>
nnoremap <C-s><C-g> :<C-u>GswRemote<SPACE>
nnoremap <C-w><C-i> :<C-u>GswSave<CR>
nnoremap <C-w><C-r> :<C-u>GswLoad<CR>
nnoremap <C-w><C-g> :<C-u>GswClearState

let &cpo = s:cpo_save
unlet s:cpo_save
