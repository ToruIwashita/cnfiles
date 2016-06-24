"" FILE: github.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

nnoremap <C-s>g :<C-u>OpenGithubProject<CR>
nnoremap <C-s><C-g> :<C-u>OpenGithubFile<CR>

function! s:open_github_file_range(line1,line2)
  silent! execute a:line1.','.a:line2.'s/\(^[^$].*[^  ]$\)/\1  /'
  silent! execute a:line1.','.a:line2.'s/\(^ \{4}.*[^ ] \{2}$\)/\1  /'
endfunction

command! -range OpenGithubFileRange call s:open_github_file_range(<line1>, <line2>)
cnorea %O %OpenGithubFileRange
cnorea '<,'>O '<,'>OpenGithubFileRange

let &cpo = s:cpo_save
unlet s:cpo_save
