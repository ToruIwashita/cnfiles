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
nmap <C-g>a <Plug>GitGutterStageHunk
" 変更を取り消し
nmap <C-g>u <Plug>GitGutterUndoHunk
" 変更のプレビュー
nmap <C-g>d <Plug>GitGutterPreviewHunk

" ファイル再読込
noremap <leader>r :<C-u>checktime<CR>:<C-u>e!<CR>:<C-u>call gitgutter#all(1)<CR>:<C-u>syntax sync fromstart<CR>

" ウィンドウの操作(ウィンドウ単体の操作はwindow_closer.vimにある)
" 現在のウィンドウで保存
noremap <C-o> :<C-u>w<CR>:<C-u>syntax sync fromstart<CR>
" バッファ全てを保存(gitgutterの関数で変更点のマーカーを消す)
noremap <leader>o :<C-u>wa<CR>:<C-u>redraw!<CR>:<C-u>call gitgutter#all(1)<CR>:<C-u>syntax sync fromstart<CR>
" バッファ全てを保存して全て閉じる
noremap <leader>x :<C-u>wa<CR>:<C-u>qa<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
