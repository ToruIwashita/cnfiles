"" ruby関連関数
command! RbSyntaxCheck call g:rb_syntax_check()

" ruby -W[level=2] warning level; 0=silence, 1=medium, 2=verbose
function! g:rb_syntax_check()
  :!ruby -c %
endfunction
