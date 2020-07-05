"" FILE: translate.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>, V:Translate<CR>
nnoremap <C-s>. V:Translate!<CR>
xmap <C-s>, <Plug>(VTranslate)
xmap <C-s>. <Plug>(VTranslateBang)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
