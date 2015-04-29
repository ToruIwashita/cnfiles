"" FILE: obsession.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:save_session()
  mks! .vim.session
endfunction

function! s:load_session()
  so .vim.session
endfunction

command! SaveS call s:save_session()
command! LoadS call s:load_session()

let &cpo = s:cpo_save
unlet s:cpo_save
