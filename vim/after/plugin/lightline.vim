"" FILE: lightline.vim
let s:cpo_save = &cpo
set cpo&vim

let g:lightline = {
  \ 'colorscheme': 'Tomorrow',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified':     'MyModified',
  \   'readonly':     'MyReadonly',
  \   'fugitive':     'MyFugitive',
  \   'filename':     'MyFilename',
  \   'fileformat':   'MyFileformat',
  \   'filetype':     'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode':         'MyMode'
  \ }
\ }

" component: MyModified
function! MyModified()
  if &filetype == 'help'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return ''
  endif
endfunction

" component: MyReadonly
function! MyReadonly()
  if &filetype == 'help'
    return ''
  elseif &readonly
    return 'RO'
  else
    return ''
  endif
endfunction

" component: MyFugitive
function! MyFugitive()
  let fname = expand("%:t")
  return (fname =~ 'NERD_tree' ? '' : exists("*fugitive#head") ? fugitive#head() != '' ? '* ' . fugitive#head() : '' : '')
endfunction

" component: MyFilename
function! MyFilename()
  let fname = expand("%:t")
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != fname ? fname =~ 'NERD_tree' ? 'NERDTree' : fname : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" component: MyFileformat
function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

" component: MyFiletype
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

" component: MyFileencoding
function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

" component: MyMode
function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let &cpo = s:cpo_save
unlet s:cpo_save
