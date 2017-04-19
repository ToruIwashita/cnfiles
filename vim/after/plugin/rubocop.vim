"" FILE: rubocop.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

function! s:rubocop_check()
  let config_file = g:lint_dir_path.'/rubocop.yml'
  if filereadable('.rubocop.yml')
    let config_file = '.rubocop.yml'
  endif

  if filereadable('./config/environment.rb')
    let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
    let g:vimrubocop_extra_args = '--rails --config '.config_file
  else
    let g:vimrubocop_rubocop_cmd = 'rbenv exec rubocop '
    let g:vimrubocop_extra_args = '--config '.config_file
  endif
  RuboCop
  unlet g:vimrubocop_extra_args
endfunction

function! s:rubocop_auto_correct()
  let config_file = g:lint_dir_path.'/rubocop.yml'
  if filereadable('.rubocop.yml')
    let config_file = '.rubocop.yml'
  endif

  if filereadable('./config/environment.rb')
    let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
    let g:vimrubocop_extra_args = '--rails --auto-correct --config '.config_file
  else
    let g:vimrubocop_rubocop_cmd = 'rbenv exec rubocop '
    let g:vimrubocop_extra_args = '--auto-correct --config '.config_file
  endif
  RuboCop
  unlet g:vimrubocop_extra_args
endfunction

" インターフェースの定義
command! RubocopCheck call s:rubocop_check()
command! RubocopAutoCorrect call s:rubocop_auto_correct()

noremap <leader>r :<C-u>RubocopCheck<CR>
noremap <leader>ra :<C-u>:w<CR>:RubocopAutoCorrect<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
