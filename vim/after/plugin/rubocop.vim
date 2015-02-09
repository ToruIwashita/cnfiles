"" FILE: rubocop.vim
let s:cpo_save = &cpo
set cpo&vim

function! s:rubocop_auto_correct()
  let g:vimrubocop_extra_args = '--auto-correct'
  RuboCop
  unlet g:vimrubocop_extra_args
endfunction

" インターフェースの定義
command! RubocopAutoCorrect call s:rubocop_auto_correct()

noremap <leader>ca :<C-u>:w<CR>:RubocopAutoCorrect<CR>

let &cpo = s:cpo_save
unlet s:cpo_save
