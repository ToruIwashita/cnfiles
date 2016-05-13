"" FILE: git_push.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-g>p :<C-u>Gsh

fun! s:git_exec_and_return_stdout(cmd)
  return substitute(system('\git '.a:cmd.' 2>/dev/null'), '\n', '', '')
endf

fun! s:git_exec(cmd)
  if system('\git '.a:cmd.' >/dev/null 2>&1; echo $?')
    throw 'error: git '.a:cmd
  endif
endf

fun! s:git_push()
  try
    let current_branch = s:git_exec_and_return_stdout('symbolic-ref --short HEAD')

    echo "push '".current_branch."' branch."

    call s:git_exec('push origin '.current_branch)
    redraw!
    echo 'pushed.'
  catch
    redraw!
    echo 'pushing failed.'
  endtry
endf

command! Gsh call s:git_push()

let &cpo = s:cpo_save
unlet s:cpo_save
