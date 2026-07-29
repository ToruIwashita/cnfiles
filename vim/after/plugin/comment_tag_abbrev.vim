"" FILE: comment_tag_abbrev.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

inoreabbrev <expr> =f g:ExpandCommentTag('TODO', v:false)
inoreabbrev <expr> #=f g:ExpandCommentTag('TODO', v:true)
inoreabbrev <expr> =q g:ExpandCommentTag('QUESTION', v:false)
inoreabbrev <expr> #=q g:ExpandCommentTag('QUESTION', v:true)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
