"" FILE: session.vim
let s:cpo_save = &cpo
set cpo&vim

" session保存ファイル名
let g:session_default_name = '.session'
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

function! s:save_session()
  SaveSession
endfunction

function! s:load_session()
  execute 'OpenSession'.g:session_default_name
endfunction

command! SaveS call s:save_session()
command! LoadS call s:load_session()

let &cpo = s:cpo_save
unlet s:cpo_save
