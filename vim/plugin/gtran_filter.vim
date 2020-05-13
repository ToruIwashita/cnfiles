"" FILE: gtran_filter.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:gtran_range_filter(bang) abort range
  let l:pos = getpos('.')

  if a:bang
    execute "'<,'>!xargs -I {} gtran -source 'ja' -target 'en' {}"
  else
    execute "'<,'>!xargs -I {} gtran {}"
  endif

  nohlsearch

  call setpos('.', l:pos)
endf

command -bang -range GtranRangeFilter call s:gtran_range_filter(<bang>0)

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
