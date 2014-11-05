"" FILE: vim-quickrun.vim 
let s:cpo_save = &cpo
set cpo&vim

" quickrunの出力結果にAnsiEscを実行して色付けする
autocmd FileType quickrun AnsiEsc

" quickrunの実行モジュールをvimprocに設定
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}

" rspecを実行するための設定定義
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'outputter': 'buffered:target=buffer',
  \ 'exec': 'bundle exec %c %s%o --color --drb --tty'
\}
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'outputter': 'buffered:target=buffer',
  \ 'exec': '%c %s%o --color --drb --tty'
\}

" :QuickRunで実行されるコマンドをrspec用の定義に設定する
" <Leader>lrをタイプした時に<ESC>:QuickRun -cmdopt '-l (カーソル行)'を実行するキーマップを定義する
function! RSpecQuickrun()
  let b:quickrun_config = {'type' : 'rspec/bundle'}
  nnoremap <expr> <leader>r ':<C-u>QuickRun -cmdopt ":' . line('.') . '"<CR>'
  nnoremap <leader>ra :<C-u>QuickRun<CR>
endfunction

" ファイル名が_spec.rbで終わるファイルを読み込んだ時に上記の設定を自動で読み込む
autocmd BufReadPost *_spec.rb call RSpecQuickrun()

let &cpo = s:cpo_save
unlet s:cpo_save
