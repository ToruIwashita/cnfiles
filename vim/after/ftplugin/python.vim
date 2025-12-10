"" FILE: python.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

iabbrev <buffer> =i from IPython import embed; embed()
iabbrev <buffer> =d import pdb; pdb.set_trace()
iabbrev <buffer> =e import traceback; traceback.print_exc()
iabbrev <buffer> =t from django.test import tag
iabbrev <buffer> =c @tag('current')
iabbrev <buffer> =h """<CR>
iabbrev <buffer> =% {%%<LEFT><SPACE><LEFT>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
