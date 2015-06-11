"" FILE: shabadou.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:running_quickrun()
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

let &cpo = s:cpo_save
unlet s:cpo_save
