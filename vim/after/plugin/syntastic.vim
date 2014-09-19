"" FILE: syntastic.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:rubocop_check()
  let g:syntastic_ruby_checkers = ['rubocop']
  SyntasticCheck
  call lightline#update()
  unlet g:syntastic_ruby_checkers
endfunction

command! RubocopCheck call s:rubocop_check()

cnorea R RubocopCheck

noremap <leader>r :<C-u>RubocopCheck<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
