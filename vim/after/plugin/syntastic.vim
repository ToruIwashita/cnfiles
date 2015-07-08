"" FILE: syntastic.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:rubocop_check()
  let g:syntastic_ruby_checkers = ['rubocop']
  if filereadable('./config/environment.rb')
    let g:syntastic_ruby_rubocop_args = '--config ~/.lint/rubocop.yml --rails'
  else
    let g:syntastic_ruby_rubocop_args = '--config ~/.lint/rubocop.yml'
  endif
  SyntasticCheck
  call lightline#update()
  unlet g:syntastic_ruby_checkers
endfunction

" インターフェースの定義
command! RubocopCheck call s:rubocop_check()

noremap <leader>a :<C-u>RubocopCheck<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
