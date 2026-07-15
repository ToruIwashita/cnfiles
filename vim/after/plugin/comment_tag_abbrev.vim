"" FILE: comment_tag_abbrev.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

inoreabbrev <expr> =f g:ExpandCommentTag('TODO')
inoreabbrev <expr> #=f g:ExpandCommentTag('TODO')
inoreabbrev <expr> =q g:ExpandCommentTag('QUESTION')
inoreabbrev <expr> #=q g:ExpandCommentTag('QUESTION')

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
