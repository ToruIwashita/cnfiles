"" FILE: over.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>o :<C-u>OverCommandLine<CR>%s/<C-r><C-w>//g<LEFT><LEFT>
nnoremap <C-s><C-o> :<C-u>OverCommandLine<CR>%s///g<LEFT><LEFT><LEFT>
nnoremap <C-s>O :<C-u>OverCommandLine<CR>%s/<C-r>"//g<LEFT><LEFT>

vnoremap <C-s><C-o> :<C-u>'<,'>OverCommandLine<CR>s///g<LEFT><LEFT><LEFT>
vnoremap <C-s>O :<C-u>'<,'>OverCommandLine<CR>s/<C-r>"//g<LEFT><LEFT>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
