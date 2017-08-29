"" FILE: ale.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" (config.plugin.vim にも設定あり)

nmap <C-a>] <Plug>(ale_next_wrap)
nmap <C-a><C-]> <Plug>(ale_next_wrap)
nmap <C-a>[ <Plug>(ale_previous_wrap)
nmap <C-a><C-[> <Plug>(ale_previous_wrap)

augroup local_ale
  autocmd!
  " lightline に依存している
  " statusline を更新するために lightline の関数を呼び出す
  autocmd User ALELint call lightline#update()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
