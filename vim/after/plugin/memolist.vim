"" FILE: ctrlp.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:memolist_path = memolist_dir_path
let g:memolist_memo_suffix = 'txt'
let g:memolist_memo_date = '%Y-%m-%d %H:%M'
let g:memolist_qfixgrep = 1

nnoremap <leader>mn :<C-u>MemoNew<CR>
nnoremap <leader>mg :<C-u>MemoGrep<CR>
execute 'nnoremap <leader>mt :<C-u>tabe '.memolist_tmp_file.'<CR>'

let &cpo = s:cpo_save
unlet s:cpo_save
