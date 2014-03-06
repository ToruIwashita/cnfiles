"" FILE: visualstar.vim 
let s:cpo_save = &cpo
set cpo&vim

map * <Plug>(visualstar-*)N
map # <Plug>(visualstar-#)N

let &cpo = s:cpo_save
unlet s:cpo_save
