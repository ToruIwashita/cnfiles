"" FILE: zsh.vim
let s:cpo_save = &cpo
set cpo&vim

setlocal makeprg=zsh\ -nu\ $*
setlocal errorformat=%f:%l:\ %m

augroup AuZshSyntaxCheck
  autocmd!
  " `BufWritePost`で`make`
  autocmd BufWritePost *.zsh silent make % | redraw!
  " `make`したら`quickfix`リストを表示
  autocmd QuickfixCmdPost make cw
augroup END

let &cpo = s:cpo_save
unlet s:cpo_save
