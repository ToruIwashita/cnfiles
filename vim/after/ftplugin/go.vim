"" FILE: go.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" tabを半角スペースとしない
setlocal noexpandtab
" tabと半角スペースの表示
setlocal listchars=tab:\ \ ,space:\ ,trail:_

"" 保存時に自動import
let g:go_fmt_command = 'goimports'

"" シンタクスハイライト
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

"" 競合解消
" go#def#Jumpとタブ移動のmap競合を解消
silent! nunmap <buffer> <C-w>]
silent! nunmap <buffer> <C-w><C-]>
" タグ移動のmapを解除
silent! nunmap <buffer> <C-]>

"" 関数
fun! s:godef_vsplit() abort
  execute 'vsplit'
  GoDef
endf

fun! s:godef_tabnew() abort
  let l:current_line_num = line('.')

  call s:godef_vsplit()

  tabedit %

  tabp
  hide
  tabn

  execute l:current_line_num
  execute 'normal! zz'
endf

"" コマンド
command! GodefVsplit call s:godef_vsplit()
command! GodefTabnew call s:godef_tabnew()

"" キーマップ
nmap <buffer> <C-s>l :<C-u>GodefVsplit<CR>
nmap <buffer> <C-s><C-l> :<C-u>GodefVsplit<CR>
noremap <buffer> <C-s>L :<C-u>GodefTabnew<CR>

" errという文字列のシンタクスハイライト
augroup local_go_vim
  autocmd!
  autocmd BufEnter *.go highlight goErr cterm=bold ctermfg=214
  autocmd BufEnter *.go match goErr /\<err\>/
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
