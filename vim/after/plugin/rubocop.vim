"" FILE: rubocop.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:rubocop_check() abort
  let l:config_file = g:lint_dir_path.'/rubocop.yml'
  if filereadable('.rubocop.yml')
    let l:config_file = '.rubocop.yml'
  endif

  if filereadable('./config/environment.rb')
    let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '
    let g:vimrubocop_config = l:config_file
  else
    let g:vimrubocop_rubocop_cmd = 'rubocop '
    let g:vimrubocop_config = l:config_file
  endif
  RuboCop
endfunction

" インターフェースの定義
command! RubocopCheck call s:rubocop_check()

" デフォルトのキーマップ無効化
noremap <leader>rwp <NOP>
noremap <leader>ru <NOP>

noremap <leader>a :<C-u>RubocopCheck<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
