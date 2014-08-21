"" FILE: go.vim
let s:cpo_save = &cpo
set cpo&vim

setlocal makeprg=go\ build\ $*
setlocal errorformat=
  \%-G#\ %.%#,
  \%-G%.%#panic:\ %m,
  \%A%f:%l:%c:\ %m,
  \%A%f:%l:\ %m,
  \%C%*\\s%m,
  \%-G%.%#

augroup AuGoSyntaxCheck
  autocmd!
  " `BufWritePost`で`make`
  autocmd BufWritePost *.go silent make % | redraw!
  " `make`したら`quickfix`リストを表示
  autocmd QuickfixCmdPost make cw
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
