"" FILE: session.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" session保存ファイル名
let g:session_default_name = 'default.session'
" session保持ファイルの拡張子
let g:session_extension = '.vim'
" session保存ディレクトリを現在のディレクトリにする
let g:session_directory = '~/.cache/vim/session'
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
    let session_name = 'default'
  endif

  exec 'SaveSession '.session_name.'.session'
endf

fun! s:load_session(...)
  if a:0
    let session_name = a:1
  else
    let session_name = 'default'
  endif

  exec 'OpenSession '.session_name.'.session'
endf

fun! s:_load_session_names(arg_lead, cmd_line, cursor_pos)
  let session_names = map(map(split(expand(g:session_directory.'/*.session.*')), 'fnamemodify(v:val, ":t")'), 'matchstr(v:val, "^\\zs\\(.*\\)\\ze\.session\.vim$", 0)')
  return filter(session_names, 'v:val =~ "^'.fnameescape(a:arg_lead).'"')
endf

command! -nargs=* SaveS call s:save_session(<f-args>)
command! -nargs=* -complete=customlist,s:_load_session_names LoadS call s:load_session(<f-args>)

let &cpo = s:cpo_save
unlet s:cpo_save
