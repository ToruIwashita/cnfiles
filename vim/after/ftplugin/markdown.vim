"" FILE: markdown.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" markdownはテキストの最大幅無し
setlocal textwidth=0
" オートインデント時の空白文字数
setlocal shiftwidth=2
" <TAB>を含むファイルを開いた際,<TAB>を何文字の空白に変換するか
setlocal tabstop=2
" キーボードで<TAB>を入力した際,<TAB>を何文字の空白に変換するか
setlocal softtabstop=2

let g:add_md_space_enabled = 1

fun! markdown#add_md_space_enabeld() abort
  return g:add_md_space_enabled
endf

" lightline.vim依存のコード
fun! s:add_md_space_toggle() abort
  if g:add_md_space_enabled
    let g:add_md_space_enabled = 0
  else
    let g:add_md_space_enabled = 1
  endif

  call lightline#update()
endf

fun! s:wrap_with_fence(...) range
  let l:opening_fence = a:0 ? '```' . a:1 : '```'
  let l:closing_fence = '```'

  " 選択範囲の開始行の1つ上の行の後に開始フェンスを挿入
  call append(a:firstline - 1, l:opening_fence)

  " 選択範囲の上に1行挿入されるため,元の最終行の位置は1つ下にずれる
  " そのためa:lastline + 1の後に終了フェンスを挿入する
  call append(a:lastline + 1, l:closing_fence)

  " カーソルを開始フェンスの行の先頭に移動する
  call cursor(a:firstline, 1)
endfunction

fun! s:add_md_space() abort
  if !g:add_md_space_enabled
    return 1
  endif

  execute 'mark Z'

  silent! execute '%s/\(^[^$].*[^ ]$\)/\1  /'

  silent! normal! `Z
  execute 'delmarks Z'
endfunction

fun! s:add_md_space_range() abort range
  if !g:add_md_space_enabled
    return 1
  endif

  silent! execute a:firstline.','.a:lastline.'s/\(^[^$].*[^ ]$\)/\1  /'
endfunction

augroup local_markdown
  autocmd!
  autocmd BufWritePre *.md call s:add_md_space()
augroup END

command! AddMdSpaceToggle call s:add_md_space_toggle()
command! -range -nargs=? WrapWithFence :<line1>,<line2>call s:wrap_with_fence(<f-args>)
command! -range MdFormat :<line1>,<line2>call s:add_md_space_range()

nnoremap <C-@> :<C-u>AddMdSpaceToggle<CR>

vnoremap <Leader>fr :WrapWithFence ruby<CR>
vnoremap <Leader>fb :WrapWithFence bash<CR>
vnoremap <Leader>fs :WrapWithFence sql<CR>
vnoremap <Leader>ff :WrapWithFence<CR>

cnorea %M %MdFormat
cnorea '<,'>M '<,'>MdFormat

ab <buffer> =b <br/>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
