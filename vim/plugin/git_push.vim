"" FILE: git_push.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

fun! s:git_push()
  let current_branch = system('\git branch symbolic-ref --short HEAD 2>&1')

  echo "push '".current_branch."' branch"
  if !system('\git push origin '.current_branch.' >/dev/null 2>&1; echo $?')
    echo 'pushed'
  else
    echo 'pushing failed'
  endif
endf

command! -range RemoveAnsiCode call s:remove_ansi_code(<line1>,<line2>)

let &cpo = s:cpo_save
unlet s:cpo_save
