"" FILE: neosnippet.vim
let s:cpo_save = &cpo
set cpo&vim

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

let &cpo = s:cpo_save
unlet s:cpo_save
