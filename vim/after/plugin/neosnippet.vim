"" FILE: neosnippet.vim
let s:cpo_save = &cpo
set cpo&vim

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

let &cpo = s:cpo_save
unlet s:cpo_save
