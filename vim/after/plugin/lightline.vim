"" FILE: lightline.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:lightline = {
  \ 'colorscheme': 'Tomorrow',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'ctrlpmark' ] ],
  \   'right': [ [ 'lineinfo', 'gutentags' ], [ 'percent' ], [ 'getcharcode', 'fileencoding', 'filetype', 'fileformat' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive':     'LightLineFugitive',
  \   'filename':     'LightLineFilename',
  \   'fileformat':   'LightLineFileformat',
  \   'filetype':     'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode':         'LightLineMode',
  \   'ctrlpmark':    'CtrlPMark',
  \   'getcharcode':  'GetCharCode'
  \ },
  \ 'component_expand': {
  \   'ale': 'ALEGetStatusLine',
  \   'gutentags': 'GutentagsStatusLine'
  \ },
  \ 'component_type': {
  \   'ale': 'error'
  \ }
\ }

let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ '' ] ]
\ }

let g:lightline.component = {
  \ 'lineinfo': 'col: %v | row: %l/%L'
\ }

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

function! GutentagsStatusLine()
  if gutentags#gutentags_enabled()
    return 'TAGS[ctags]'
  else
    return 'TAGS[]'
  endif
endfunction

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
         \ fname == '__Tagbar__' ? g:lightline.fname :
         \ fname =~ '__Gundo\|NERD_tree' ? '' :
         \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
         \ &ft == 'unite' ? unite#get_status_string() :
         \ &ft == 'vimshell' ? vimshell#get_status_string() :
         \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
         \ ('' != fname ? fname : '[No Name]') .
         \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no filetype') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
         \ fname == 'ControlP' ? 'CtrlP' :
         \ fname == '__Gundo__' ? 'Gundo' :
         \ fname == '__Gundo_Preview' ? 'Gundo Preview' :
         \ fname =~ 'NERD_tree' ? 'NERDTree' :
         \ &ft == 'unite' ? 'Unite' :
         \ &ft == 'vimfiler' ? 'VimFiler' :
         \ &ft == 'vimshell' ? 'VimShell' :
         \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
\ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! GetCharCode()
  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
