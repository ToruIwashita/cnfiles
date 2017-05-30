"" FILE: modeling_session.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

fun! s:load_modeling_session()
  exec 'source' g:markdown_texts_modeling_session_file_path
endf

command! LoadModelingSession call s:load_modeling_session()

let &cpo = s:cpo_save
unlet s:cpo_save
