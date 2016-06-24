"" FILE: github.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>g :<C-u>OpenGithubProject<CR>
nnoremap <C-s><C-g> :<C-u>OpenGithubFile<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
