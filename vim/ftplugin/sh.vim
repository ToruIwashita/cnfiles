"" FILE: sh.vim
let s:cpo_save = &cpo
set cpo&vim

setlocal makeprg=sh\ -nu\ $*
setlocal errorformat=%f:\ line\ %l:\ %m

augroup AuShSyntaxCheck
  autocmd!
  " `BufWritePost`で`make`
  autocmd BufWritePost *.sh,*.bash silent make % | redraw!
  " `make`したら`quickfix`リストを表示
  autocmd QuickfixCmdPost make cw
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
