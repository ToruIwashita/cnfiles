"" FILE: gitgutter.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" 変更点へ移動
noremap <silent> <C-g>n :<C-u>GitGutterNextHunk<CR>zz
noremap <silent> <C-g><C-n> :<C-u>GitGutterNextHunk<CR>zz
noremap <silent> <C-g>p :<C-u>GitGutterPrevHunk<CR>zz
noremap <silent> <C-g><C-p> :<C-u>GitGutterPrevHunk<CR>zz

" 変更を追加
nmap <C-g>a <Plug>(GitGutterStageHunk)
" 変更を取り消し
nmap <C-g>u <Plug>(GitGutterUndoHunk)
" 変更のプレビュー
nmap <C-g>d <Plug>(GitGutterPreviewHunk)

" ファイル再読込
noremap <leader>r :<C-u>checktime<CR>:e!<CR>:call gitgutter#all(1)<CR>:syntax sync fromstart<CR>

" 保存に関する操作(似た設定がwindow_closer.vimにもある)
" 現在のウィンドウで保存
noremap <C-o> :<C-u>w<CR>:syntax sync fromstart<CR>
" バッファ全てを保存(gitgutterの関数で変更点のマーカーを消す)
noremap <leader>o :<C-u>wa<CR>:redraw!<CR>:call gitgutter#all(1)<CR>:syntax sync fromstart<CR>
" バッファ全てを保存して全て閉じる
noremap <leader>x :<C-u>wa<CR>:qa<CR>
" 現在のタブを閉じる
noremap <leader>e :<C-u>tabclose<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
