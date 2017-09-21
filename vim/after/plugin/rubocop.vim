"" FILE: rubocop.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:rubocop_check()
  let l:config_file = g:lint_dir_path.'/rubocop.yml'
  if filereadable('.rubocop.yml')
    let l:config_file = '.rubocop.yml'
  endif

  if filereadable('./config/environment.rb')
    let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
    let g:vimrubocop_config = l:config_file
    let g:vimrubocop_extra_args = '--rails --require rubocop-rspec'
  else
    let g:vimrubocop_rubocop_cmd = 'rbenv exec rubocop '
    let g:vimrubocop_config = l:config_file
    let g:vimrubocop_extra_args = '--require rubocop-rspec'
  endif
  RuboCop
  unlet g:vimrubocop_extra_args
endfunction

function! s:rubocop_auto_correct()
  let l:config_file = g:lint_dir_path.'/rubocop.yml'
  if filereadable('.rubocop.yml')
    let l:config_file = '.rubocop.yml'
  endif

  if filereadable('./config/environment.rb')
    let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
    let g:vimrubocop_config = l:config_file
    let g:vimrubocop_extra_args = '--rails --require rubocop-rspec --auto-correct'
  else
    let g:vimrubocop_rubocop_cmd = 'rbenv exec rubocop '
    let g:vimrubocop_config = l:config_file
    let g:vimrubocop_extra_args = '--require rubocop-rspec --auto-correct'
  endif
  RuboCop
  unlet g:vimrubocop_extra_args
endfunction

" インターフェースの定義
command! RubocopCheck call s:rubocop_check()
command! RubocopAutoCorrect call s:rubocop_auto_correct()

noremap <leader>a :<C-u>RubocopCheck<CR>
noremap <leader>as :<C-u>:w<CR>:RubocopAutoCorrect<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
