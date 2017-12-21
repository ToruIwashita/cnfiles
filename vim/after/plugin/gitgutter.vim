"" FILE: gitgutter.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" 変更点へ移動
noremap <C-g>n :<C-u>GitGutterNextHunk<CR>zz
noremap <C-g><C-n> :<C-u>GitGutterNextHunk<CR>zz
noremap <C-g>p :<C-u>GitGutterPrevHunk<CR>zz
noremap <C-g><C-p> :<C-u>GitGutterPrevHunk<CR>zz

" 変更を追加
nmap <C-g>a <Plug>GitGutterStageHunk
" 変更を取り消し
nmap <C-g>u <Plug>GitGutterUndoHunk
" 変更のプレビュー
nmap <C-g>d <Plug>GitGutterPreviewHunk

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
