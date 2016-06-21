"" FILE: ctrlsf.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

let g:ctrlsf_indent = 2           " 結果前方のインデント数
let g:ctrlsf_context = '-C 2'     " ヒットした文字列の前後表示行数
let g:ctrlsf_position = 'bottom'  " 結果の出す位置
let g:ctrlsf_winsize = &lines/3   " 結果ウィンドウサイズ
" 検索結果画面のキーマップ
let g:ctrlsf_mapping = {
  \ 'open':  ['<CR>', 'o'],
  \ 'openb': '<C-o>',
  \ 'split': 's',
  \ 'tab':   't',
  \ 'tabb':  '<C-t>',
  \ 'quit':  'q',
  \ 'next':  '<C-n>',
  \ 'prev':  '<C-p>'
\ }

fun! s:ctrlsf_settings()
  nnoremap <buffer> <C-s> :<C-u>call ctrlsf#JumpTo('split')<CR>:<C-u>CtrlSFOpen<CR>
endf

fun! s:buffer_ctrlsf(keyword)
  let buflist = join(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'), ' ')
  exec 'CtrlSF '.a:keyword.' '.buflist
endf

nmap <C-s>s <Plug>CtrlSFCwordPath<CR>
nmap <C-s>* <Plug>CtrlSFPwordPath<CR>
vmap <C-s>s <Plug>CtrlSFVwordExec
nnoremap <C-s><C-s> :<C-u>execute 'BCtrlSF '.expand('<cword>')<CR>
nnoremap <C-s>f :<C-u>CtrlSF<SPACE>
nnoremap <C-s><C-f> :<C-u>BCtrlSF<SPACE>
nnoremap <C-s>w :<C-u>CtrlSFToggle<CR>

command! -nargs=1 BCtrlSF call s:buffer_ctrlsf(<q-args>)

augroup local_ctrlsf
  autocmd!
  autocmd FileType ctrlsf call s:ctrlsf_settings()
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
