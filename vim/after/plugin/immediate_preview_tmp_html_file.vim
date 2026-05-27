"" FILE: immediate_preview_tmp_html_file.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-s>- :<C-u>ImmediatePreviewTmpDumpHtmlFile<CR>
nnoremap <C-s>^ :<C-u>ImmediatePreviewTmpHtmlFile<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
