"" FILE: easy_align.vim
let s:cpo_save = &cpo
set cpo&vim

cnorea E EasyAlign
cnorea '<,'>E '<,'>EasyAlign
vmap <CR> <Plug>(EasyAlign)

let &cpo = s:cpo_save
unlet s:cpo_save
