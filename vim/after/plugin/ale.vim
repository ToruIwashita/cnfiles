"" FILE: ale.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" (config.plugin.vim にも設定あり)

nmap <C-a>n <Plug>(ale_next_wrap)
nmap <C-a><C-n> <Plug>(ale_next_wrap)
nmap <C-a>p <Plug>(ale_previous_wrap)
nmap <C-a><C-p> <Plug>(ale_previous_wrap)

augroup local_ale
  autocmd!
  " lightline に依存している
  " statusline を更新するために lightline の関数を呼び出す
  autocmd User ALELint call lightline#update()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
