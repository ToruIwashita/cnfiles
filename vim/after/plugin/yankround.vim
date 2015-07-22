"" FILE: yankround.vim
let s:cpo_save = &cpo
set cpo&vim

nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

let &cpo = s:cpo_save
unlet s:cpo_save
