"" FILE: git_status.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:NERDTreeIndicatorMapCustom = {
  \ 'Modified'  : 'M',
  \ 'Staged'    : 'S',
  \ 'Untracked' : 'U',
  \ 'Renamed'   : 'R',
  \ 'Deleted'   : 'D',
  \ 'Ignored'   : 'I',
  \ 'Clean'     : '✔︎',
  \ 'Dirty'     : '✗',
  \ 'Unmerged'  : '⚠',
  \ 'Unknown'   : '?'
\ }

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
