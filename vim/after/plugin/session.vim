"" FILE: session.vim
let s:cpo_save = &cpo
set cpo&vim

" session保存ファイル名
let g:session_default_name = '.default.session'
" session保持ファイルの拡張子
let g:session_extension = '.vim'
" session保存ディレクトリを現在のディレクトリにする
let g:session_directory = getcwd()
" vim終了時に自動保存しない
let g:session_autosave = 'no'
" 引数なしでvimを起動した時にセッションを復元しない
let g:session_autoload = 'no'
" 1分間に1回自動保存をしない(する場合は1)
let g:session_autosave_periodic = 0

fun! s:save_session(...)
  if a:0
    let session_name = a:1
  else
    let session_name = fugitive#head()
  end

  if strlen(session_name)
    execute 'SaveSession .'.session_name.'.session'
  else
    SaveSession
  endif
endf

fun! s:load_session(...)
  if a:0
    let session_name = a:1
  else
    let session_name = fugitive#head()
  end
  
  if strlen(session_name)
    execute 'OpenSession .'.session_name.'.session'
  else
    execute 'OpenSession '.g:session_default_name
  endif
endf

fun! s:git_branches(arg_lead, cmd_line, cursor_pos)
  let branches = filter(split(system('git branch')), 'v:val != "*"')

  if branches[0] == 'fatal:'
    return []
  endif

  return filter(branches, 'v:val =~ "^'. fnameescape(a:arg_lead) . '"')
endf

command! -nargs=? SaveS call s:save_session(<f-args>)
command! -nargs=? LoadS call s:load_session(<f-args>)
command! -nargs=1 -complete=customlist,s:git_branches Gsw :<C-u>Git checkout <args>:<C-u>LoadS<CR>

cnorea S SaveS
cnorea L LoadS
cnorea G Gsw

nnoremap <C-w><C-i> :<C-u>SaveS<CR>
nnoremap <C-w><C-r> :<C-u>LoadS<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
