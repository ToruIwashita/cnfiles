"" FILE: shabadou.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:running_quickrun() abort
  return shabadou#make_quickrun_hook_anim(
    \ 'running',
    \ [
    \   ':QuickRun |',
    \   ':QuickRun /',
    \   ':QuickRun -',
    \   ':QuickRun \'
    \ ],
    \ 3
  \ )
endfunction

call quickrun#module#register(s:running_quickrun())

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
