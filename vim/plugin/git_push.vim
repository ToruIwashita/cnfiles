"" FILE: git_push.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-g>p :<C-u>Gsh

fun! s:git_exec(cmd) abort
  let results = split(system('\git '.a:cmd.' 2>/dev/null; echo $?'), '\n')
  let exit_status = remove(results, -1)

  if exit_status
    throw 'failed to '.a:cmd
  endif

  return join(results, '\n')
endf

fun! s:git_push(bang) abort
  try
    let current_branch = s:git_exec('symbolic-ref --short HEAD')

    echo "push '".current_branch."' branch."

    let opt = ''
    if a:bang
      if confirm('force push with-lease?', "&Yes\n&No", 1) != 1
        return 1
      endif

      let opt = ' --force-with-lease'
    endif

    call s:git_exec('push'.opt.' origin '.current_branch)
    redraw!
    echo 'pushed.'
  catch
    redraw!
    echo v:exception
  endtry
endf

command! -bang Gsh call s:git_push(<bang>0)

let &cpo = s:cpo_save
unlet s:cpo_save
