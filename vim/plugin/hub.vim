"" FILE: hub.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:open_pull_request_from_branch()
  call system('\hub browse -- pull/$(git rev-parse --abbrev-ref HEAD) 2>/dev/null')
endf

command! OpenPullRequestFromBranch call s:open_pull_request_from_branch()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
