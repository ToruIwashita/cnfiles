"" FILE: gitgutter.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

" 変更点へ移動
nmap <C-g>] <Plug>GitGutterNextHunk
nmap <C-g><C-]> <Plug>GitGutterNextHunk
nmap <C-g>[ <Plug>GitGutterPrevHunk
nmap <C-g><C-[> <Plug>GitGutterPrevHunk

" 変更を追加
nmap <C-g>a <Plug>GitGutterStageHunk
" 変更を取り消し
nmap <C-g>u <Plug>GitGutterUndoHunk
" 変更のプレビュー
nmap <C-g>d <Plug>GitGutterPreviewHunk

let &cpo = s:cpo_save
unlet s:cpo_save
