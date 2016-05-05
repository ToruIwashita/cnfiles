"" FILE: gitv.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <leader>ga :<C-u>Gitv! --all<CR>
nnoremap <leader>gl :<C-u>Gitv --all<CR>

" FileTypeがgitの場合に折りたたみを行わない
augroup set_filetype_git_foldlevel
  autocmd!
  autocmd FileType git :setlocal foldlevel=100
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
