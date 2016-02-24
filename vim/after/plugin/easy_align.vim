"" FILE: easy_align.vim
let s:cpo_save = &cpo
set cpo&vim

vmap <CR> <Plug>(EasyAlign)

let &cpo = s:cpo_save
unlet s:cpo_save
