"" markdown関連関数
command! AddMdSpace call g:add_md_space()

function! g:add_md_space()
  try
    :%s/\(^[^$].*[^  ]$\)/\1  /
    :%s/\(^ \{4}.*[^ ] \{2}$\)/\1  /
  catch
  endtry
endfunction
