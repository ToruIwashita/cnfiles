"" FILE: python.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

ab <buffer> =i from IPython import embed; embed()
ab <buffer> =p import pdb; pdb.set_trace()
ab <buffer> =t from django.test import tag
ab <buffer> =c @tag('current')
ab <buffer> =d """<CR>
ab <buffer> =% {%%<LEFT><SPACE><LEFT>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
