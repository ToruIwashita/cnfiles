"" FILE: expand_region.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

"" vim-expand-region
map <C-l> <Plug>(expand_region_expand)
map <C-h> <Plug>(expand_region_shrink)

"" 以下のpluginに依存している
" vim-textobj-user
" vim-textobj-line
" vim-textobj-indent
let g:expand_region_text_objects = {
  \ 'iW' :0,
  \ "i'" :0, "a'" :0,
  \ 'i"' :0, 'a"' :0,
  \ 'i`' :0, 'a`' :0,
  \ 'i)' :1, 'a)' :1,
  \ 'i]' :1, 'a]' :1,
  \ 'i}' :1, 'a}' :1,
  \ 'i>' :1, 'a>' :1,
  \ 'it' :0, 'at' :0,
  \ 'il' :0, 'al' :0,
  \ 'ii' :0, 'ai' :0,
  \ 'is' :0, 'as' :0,
  \ 'ip' :0, 'ap' :0
\ }

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
