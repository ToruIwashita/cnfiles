"" FILE: ctrlp.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>mn :<C-u>MemoNew<CR>
nnoremap <leader>mg :<C-u>MemoGrep<CR>

let g:memolist_path = home_dir_path.'/.memolist'
let g:memolist_memo_suffix = 'txt'
let g:memolist_memo_date = '%Y-%m-%d %H:%M'
let g:memolist_qfixgrep = 1

let &cpo = s:cpo_save
unlet s:cpo_save
