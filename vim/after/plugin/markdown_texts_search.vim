"" FILE: markdown_texts_search.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>M :<C-u>MarkdownTextsSearch<SPACE>''<LEFT>
vnoremap <leader>M :<C-u>MarkdownTextsSearchRange<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
