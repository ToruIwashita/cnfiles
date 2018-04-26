"" FILE: confirmation_of_included_feature.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

cnorea C ConfirmIncludedFeature

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
