"" FILE: confirmation_of_included_feature.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

function! s:confirm_included_feature()
  echo 'has ruby '.has('ruby')
  echo 'has python3 '.has('python3')
  echo 'has lua '.has('lua')
endfunction

command! ConfirmIncludedFeature call s:confirm_included_feature()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
