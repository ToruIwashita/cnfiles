"" FILE: modeling_session.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:load_modeling_session()
  exec 'source' g:markdown_texts_modeling_session_file_path
endf

fun! s:save_modeling_session()
  let current_ssop = &sessionoptions

  set sessionoptions-=options
  exec 'mksession!' g:markdown_texts_modeling_session_file_path
  let &sessionoptions = current_ssop
endf

command! LoadModelingSession call s:load_modeling_session()
command! SaveModelingSession call s:save_modeling_session()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
