"" FILE: ctrlp.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:memolist_path = g:memolist_dir_path
let g:memolist_memo_suffix = 'md'
let g:memolist_memo_date = '%Y-%m-%d %H:%M'
let g:memolist_qfixgrep = 1

nnoremap <leader>mn :<C-u>MemoNew<CR>
nnoremap <leader>mg :<C-u>MemoGrep<CR>
execute 'nnoremap <leader>mm :<C-u>e '.g:memolist_tmp_markdown_file_path.'<CR>'
execute 'nnoremap <leader>mt :<C-u>e '.g:memolist_tmp_text_file_path.'<CR>'

augroup local_memolist
  autocmd!
  execute 'autocmd BufRead,BufNewFile ' . g:memolist_tmp_text_file_path . ' setlocal textwidth=0'
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
