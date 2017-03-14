"" FILE: tagbar.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:tagbar_ctags_bin = local_dir_path.'/bin/ctags'
let g:tagbar_autofocus = 1
let g:tagbar_left = 1
let g:tagbar_compact = 1
let g:tagbar_type_ruby = {
  \ 'kinds': [
  \   'm:modules:0:1',
  \   'c:classes:0:1',
  \   'f:methods:0:1',
  \   'F:singleton methods:0:1'
  \ ],
  \ 'kind2scope': {
  \   'm': 'module',
  \   'c': 'class',
  \   'f': 'method',
  \   'F': 'singleton method'
  \ }
\ }

noremap <C-w>, :<C-u>TagbarToggle<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
