"" FILE: lightline.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" lightline.vimは様々なpluginに依存している

let g:lightline = {
  \ 'colorscheme': 'Tomorrow',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'readonly', 'linter_errors', 'linter_warnings' ], [ 'ctrlpmark' ] ],
  \   'right': [ [ 'deoplete', 'mdspace', 'gutentags', 'lineinfo' ], [ 'percent' ], [ 'getcharcode', 'fileencoding', 'filetype', 'fileformat' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive':     'LightlineFugitive',
  \   'filename':     'LightlineFilename',
  \   'fileformat':   'LightlineFileformat',
  \   'filetype':     'LightlineFiletype',
  \   'fileencoding': 'LightlineFileencoding',
  \   'mode':         'LightlineMode',
  \   'ctrlpmark':    'LightlineCtrlPMark',
  \   'getcharcode':  'LightlineGetCharCode'
  \ },
  \ 'component_expand': {
  \   'readonly':        'LightlineReadonly',
  \   'linter_warnings': 'LightlineLinterWarnings',
  \   'linter_errors':   'LightlineLinterErrors',
  \   'deoplete':        'LightlineDeopleteStatusLine',
  \   'mdspace':         'LightlineMdSpaceStatusLine',
  \   'gutentags':       'LightlineGutentagsStatusLine'
  \ },
  \ 'component_type': {
  \   'readonly':        'error',
  \   'linter_warnings': 'warning',
  \   'linter_errors':   'error'
  \ }
\ }

let g:lightline.tabline = {
  \ 'left': [ [ 'tabs' ] ],
  \ 'right': [ [ '' ] ]
\ }

let g:lightline.component = {
  \ 'lineinfo': 'c: %v | r: %l/%L'
\ }

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

function! LightlineMdSpaceStatusLine()
  if &filetype !=# 'markdown' || winwidth(0) <= 100
    return ''
  endif

  if exists('*markdown#add_md_space_enabeld()') && markdown#add_md_space_enabeld()
    return 'mdspace[*]'
  else
    return 'mdspace[]'
  endif
endfunction

function! LightlineGutentagsStatusLine()
  if &filetype ==# 'markdown' || &filetype ==# 'text' || winwidth(0) <= 100
    return ''
  endif

  if gutentags#gutentags_enabled()
    return 'ctags[*]'
  else
    return 'ctags[]'
  endif
endfunction

function! LightlineDeopleteStatusLine()
  if deoplete#is_enabled()
    return 'ctags[*]'
  else
    return 'ctags[]'
  endif
endfunction

function! LightlineModified()
  return &filetype =~# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &filetype !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &filetype !~? 'vimfiler' && exists('*FugitiveHead')
      let l:mark = ''  " edit here for cool mark
      let l:head = FugitiveHead()
      return strlen(l:head) ? l:mark.l:head : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFilename()
  let l:fname = expand('%:t')

  return l:fname ==# 'ControlP' ? g:lightline.ctrlp_item :
        \ l:fname ==# '__Tagbar__' ? g:lightline.fname :
        \ l:fname =~# '__Gundo\|NERD_tree' ? '' :
        \ &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ ('' !=# l:fname ? l:fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 100 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 100 ? (strlen(&filetype) ? &filetype : 'no filetype') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 100 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! LightlineMode()
  let l:fname = expand('%:t')

  return l:fname ==# '__Tagbar__' ? 'Tagbar' :
        \ l:fname ==# 'ControlP' ? 'CtrlP' :
        \ l:fname ==# '__Gundo__' ? 'Gundo' :
        \ l:fname ==# '__Gundo_Preview' ? 'Gundo Preview' :
        \ l:fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineLinterWarnings()
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf('⚠ %d', l:all_non_errors)
endfunction

function! LightlineLinterErrors()
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf('✗ %d', l:all_errors)
endfunction

function! LightlineCtrlPMark()
  if expand('%:t') =~# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
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

function! TagbarStatusFunc(current, sort, fname, ...)
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! LightlineGetCharCode()
  " Get the output of :ascii
  if winwidth(0) <= 100
    return ''
  endif

  redir => l:ascii
  silent! ascii
  redir END

  if match(l:ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let l:nrformat = '0x%02x'

  let l:encoding = (&fileencoding ==# '' ? &encoding : &fileencoding)

  if l:encoding ==# 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let l:nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [l:str, l:char, l:nr; l:rest] = matchlist(l:ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let l:nr = printf(l:nrformat, l:nr)

  return "'". l:char ."' ". l:nr
endfunction

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
