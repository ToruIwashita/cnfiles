"" FILE: ale.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" (config.plugin.vimにも設定あり)

nmap <silent> <C-a>n <Plug>(ale_next_wrap)
nmap <silent> <C-a><C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-a>p <Plug>(ale_previous_wrap)
nmap <silent> <C-a><C-p> <Plug>(ale_previous_wrap)

noremap <leader>af :<C-u>ALEFix<CR>

augroup local_ale
  autocmd!
  " lightline.vimに依存している
  " statuslineを更新するためにlightlineの関数を呼び出す
  autocmd BufWritePre * ALEFix
  autocmd User ALELintPost call lightline#update()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
