"" FILE: previm.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:previm_enable_realtime = 1
let g:previm_show_header = 0
let g:previm_plantuml_imageprefix = 'http://localhost:8888/img/'
let g:previm_disable_default_css = 1
let g:previm_custom_css_path = g:config_dir_path.'/github-markdown-dark.override.css'

" markdown以外のバッファ用フォールバック(buffer-localマッピングが優先されるため,markdownでは上のPrevimOpenが発火する)
nnoremap <C-s>v :<C-u>ImmediatePreviewTmpDumpMarkdownFile<CR>
nnoremap <C-s>V :<C-u>ImmediatePreviewTmpMarkdownFile<CR>

fun! s:previm_setting() abort
  nnoremap <buffer> <C-s>v :<C-u>PrevimOpen<CR>
endf

" 指定されたmarkdownファイルを即座にブラウザでプレビューする
" :hide修飾で元バッファを保持したまま対象ファイルへ切替えてPrevimOpenし元バッファへ戻す
" :viewでreadonly化,SwapExists autocmdでswpファイル警告を自動で'o'(open read-only)選択しスキップする
fun! s:immediate_preview_markdown_file(file_path) abort
  if empty(a:file_path)
    echohl ErrorMsg | echo 'Error: markdown file path is empty' | echohl None
    return
  endif

  let l:save_bufnr = bufnr('%')

  augroup immediate_preview_markdown_file_swap
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
  augroup END

  try
    execute 'hide view ' . fnameescape(a:file_path)
    PrevimOpen
  finally
    autocmd! immediate_preview_markdown_file_swap
    augroup! immediate_preview_markdown_file_swap
    execute 'hide buffer ' . l:save_bufnr
  endtry
endf

command! ImmediatePreviewTmpDumpMarkdownFile call s:immediate_preview_markdown_file(g:memolist_tmp_dump_markdown_file_path)
command! ImmediatePreviewTmpMarkdownFile call s:immediate_preview_markdown_file(g:memolist_tmp_markdown_file_path)

augroup local_previm
  autocmd!
  autocmd FileType markdown call s:previm_setting()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
