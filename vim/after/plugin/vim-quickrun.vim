"" FILE: vim-quickrun.vim 
let s:cpo_save = &cpo
set cpo&vim

" quickrunの実行モジュールをvimprocに設定
let g:quickrun_config = {
  \ '_': {
  \   'runner': 'vimproc',
  \   'runner/vimproc/updatetime': 40,
  \   'hook/running/enable': 1
  \ }
\ }

" rspecを実行するための設定定義
let s:rspec_quickrun_config = {
  \ 'command': 'rspec',
  \ 'outputter': 'buffered:target=buffer',
\ }

let g:quickrun_config['rspec/normal'] = extend(copy(s:rspec_quickrun_config), {
  \ 'type': 'rspec/normal',
  \ 'exec': '%c %s%o --color --tty'
\ })

let g:quickrun_config['rspec/bundle'] = extend(copy(s:rspec_quickrun_config), {
  \ 'type': 'rspec/bundle',
  \ 'exec': 'bundle exec %c %s%o --color --tty'
\ })

let g:quickrun_config['rspec/spring'] = extend(copy(s:rspec_quickrun_config), {
  \ 'type': 'rspec/spring',
  \ 'exec': 'bundle exec spring rspec %s%o --color --tty'
\ })

" :QuickRunで実行されるrpsecコマンドを定義する
" <leader>r,<leader>raをタイプした時に<ESC>:QuickRun [-cmdopt  '-l (カーソル行)']を実行するキーマップを定義する
function! RSpecQuickrun()
  if filereadable('./bin/spring')
    let b:quickrun_config = {'type': 'rspec/spring'}
  else
    let b:quickrun_config = {'type': 'rspec/bundle'}
  endif

  nnoremap <expr> <leader>r ':<C-u>:wa<CR>:QuickRun -cmdopt ":'.line('.').'"<CR>'
  nnoremap <leader>ra :<C-u>:wa<CR>:QuickRun<CR>
endfunction

" 設定変更用の関数
function! s:set_rspec_quickrun(arg)
  if match(a:arg, 'spring') != -1
    let b:quickrun_config = {'type': 'rspec/spring'}
  elseif match(a:arg, 'bundle') != -1
    let b:quickrun_config = {'type': 'rspec/bundle'}
  else
    let b:quickrun_config = {'type': 'rspec/normal'}
  endif
  echo a:arg
endfunction

" 設定変更の用インターフェース
command! -nargs=1 SetRspecQuickrun call s:set_rspec_quickrun(<args>)
" quickrunの中断用インターフェース
command! StopQuickrun call quickrun#sweep_sessions()

" quickrunの出力結果にAnsiEscを実行して色付けする
augroup Quickrun
  autocmd!
  autocmd FileType quickrun AnsiEsc
  autocmd BufReadPost *_spec.rb call RSpecQuickrun()
augroup END

nnoremap <expr> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

let &cpo = s:cpo_save
unlet s:cpo_save
