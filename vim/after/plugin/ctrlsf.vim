"" FILE: ctrlsf.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:ctrlsf_indent = 2           " 結果前方のインデント数
let g:ctrlsf_context = '-C 2'     " ヒットした文字列の前後表示行数
let g:ctrlsf_position = 'bottom'  " 結果の出す位置
let g:ctrlsf_winsize = &lines/3   " 結果ウィンドウサイズ
" 検索結果画面のキーマップ
let g:ctrlsf_mapping = {
  \ 'open':  'o',
  \ 'openb': ['<CR>'],
  \ 'tab':   't',
  \ 'tabb':  '<C-t>',
  \ 'quit':  'q',
  \ 'next':  '<C-n>',
  \ 'prev':  '<C-p>'
\ }

fun! s:ctrlsf_setting() abort
  nnoremap <buffer> <C-s> :<C-u>call ctrlsf#JumpTo('split')<CR>:<C-u>CtrlSFOpen<CR><C-w><C-p>
  nnoremap <buffer> <C-i> :<C-u>call ctrlsf#JumpTo('vsplit')<CR>:<C-u>CtrlSFOpen<CR><C-w><C-p>
endf

fun! s:buffer_ctrlsf(keyword) abort
  let l:buflist = join(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'), ' ')
  exec 'CtrlSF '.a:keyword.' '.l:buflist
endf

fun! s:buffer_ctrlsf_range() range
  let l:unnamed_register = @@
  silent! normal! gvy
  let l:selected_range = @@
  let @@ = l:unnamed_register

  if l:selected_range =~# "'"
    let l:escapted_selected_range = '"'.escape(l:selected_range, ' \"').'"'
  elseif l:selected_range =~# '[ \"]'
    let l:escapted_selected_range = string(l:selected_range)
  else
    let l:escapted_selected_range = l:selected_range
  endif

  let l:buflist = join(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'), ' ')
  exec 'CtrlSF '.l:escapted_selected_range.' '.l:buflist
endf

command! -nargs=1 BCtrlSF call s:buffer_ctrlsf(<q-args>)
command! -range BCtrlSFRange call s:buffer_ctrlsf_range()

" NORMALモード
nmap <C-s>s <Plug>CtrlSFCwordPath<CR>
nnoremap <C-s><C-s> :<C-u>execute 'BCtrlSF '.expand('<cword>')<CR>
" VISUALモード
vmap <C-s>s <Plug>CtrlSFVwordExec
vnoremap <C-s><C-s> :<C-u>BCtrlSFRange<CR>
" 検索ワードで検索
nmap <C-s>* <Plug>CtrlSFPwordPath<CR>
" 結果表示・非表示
nnoremap <C-s>w :<C-u>CtrlSFToggle<CR>
" 入力の省略
nnoremap <C-s>f :<C-u>CtrlSF<SPACE>
nnoremap <C-s><C-f> :<C-u>BCtrlSF<SPACE>

augroup local_ctrlsf
  autocmd!
  autocmd FileType ctrlsf call s:ctrlsf_setting()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
