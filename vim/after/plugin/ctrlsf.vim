"" FILE: ctrlsf.vim
let s:cpo_save = &cpo
set cpo&vim

fun! s:buffer_ctrlsf(keyword)
  let buflist = join(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'), ' ')
  exec 'CtrlSF '.a:keyword.' '.buflist
endf

command! -nargs=1 BCtrlSF call s:buffer_ctrlsf(<q-args>)

nnoremap <C-s>s <Plug>CtrlSFCwordPath<CR>
nnoremap <C-s><C-s> :<C-u>execute 'BCtrlSF '.expand('<cword>')<CR>
nnoremap <C-s>* <Plug>CtrlSFPwordPath<CR>
nnoremap <C-s>f :<C-u>CtrlSF<SPACE>
nnoremap <C-s><C-f> :<C-u>BCtrlSF<SPACE>
nnoremap <C-s><C-w> :<C->CtrlSFToggle<CR>
vnoremap <C-s>s <Plug>CtrlSFVwordExec

let &cpo = s:cpo_save
unlet s:cpo_save
