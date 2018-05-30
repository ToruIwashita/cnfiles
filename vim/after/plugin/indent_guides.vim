"" FILE: indent_guides.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 8

hi IndentGuidesEven ctermbg=236
hi IndentGuidesOdd  ctermbg=235

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
