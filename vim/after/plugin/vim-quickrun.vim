"" FILE: vim-quickrun.vim 
set encoding=utf-8
scriptencoding utf-8

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
  \ 'outputter': 'buffered:target=buffer'
\ }

let g:quickrun_config['rspec/normal'] = extend(copy(s:rspec_quickrun_config), {
  \ 'type': 'rspec/normal',
  \ 'exec': 'time %c %s%o --color --tty'
\ })

let g:quickrun_config['rspec/bundle'] = extend(copy(s:rspec_quickrun_config), {
  \ 'type': 'rspec/bundle',
  \ 'exec': 'time bundle exec %c %s%o --color --tty'
\ })

let g:quickrun_config['rspec/bin'] = extend(copy(s:rspec_quickrun_config), {
  \ 'type': 'rspec/bin',
  \ 'exec': 'time ./bin/rspec %s%o --color --tty'
\ })

" :QuickRunで実行されるrpsecコマンドを定義する
" <leader>r,<leader>raをタイプした時に<ESC>:QuickRun [-cmdopt  '-l (カーソル行)']を実行するキーマップを定義する
function! s:rspec_quickrun()
  if filereadable('./bin/rspec')
    let b:quickrun_config = {'type': 'rspec/bin'}
  else
    let b:quickrun_config = {'type': 'rspec/bundle'}
  endif

  nnoremap <expr> <leader>s ':<C-u>:wa<CR>:QuickRun -cmdopt ":'.line('.').'"<CR>'
  nnoremap <leader>sa :<C-u>:wa<CR>:QuickRun<CR>
endfunction

" 設定変更用の関数
function! s:switch_rspec_quickrun(arg)
  if match(a:arg, 'bin') != -1
    let b:quickrun_config = {'type': 'rspec/bin'}
  elseif match(a:arg, 'bundle') != -1
    let b:quickrun_config = {'type': 'rspec/bundle'}
  elseif match(a:arg, 'normal') != -1
    let b:quickrun_config = {'type': 'rspec/normal'}
  else
    if exists('b:quickrun_config')
      echo b:quickrun_config['type']
      return
    endif
  endif

  echo a:arg
endfunction

" 設定変更可能なrspecの種類補完
fun! s:_types_of_rspec(...)
  return filter(['normal', 'bundle', 'bin'], 'v:val =~ "^'.fnameescape(a:1).'"')
endf

" 設定変更の用インターフェース
command! -nargs=? -complete=customlist,s:_types_of_rspec SwitchRspecQuickrun call s:switch_rspec_quickrun(<q-args>)
" quickrunの中断用インターフェース
command! StopQuickrun call quickrun#sweep_sessions()

" quickrunの出力結果にAnsiEscを実行して色付けする
augroup local_vim_quickrun
  autocmd!
  autocmd FileType quickrun AnsiEsc
  autocmd BufReadPost *_spec.rb call s:rspec_quickrun()
augroup END

nnoremap <expr> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

let &cpo = s:cpo_save
unlet s:cpo_save
