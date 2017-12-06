"" FILE: EasyMotion.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" invalidate default easymotion-prefix
map <leader>, <NOP>

" move to {char}
map <C-f> <Plug>(easymotion-bd-f)
nmap <C-f> <Plug>(easymotion-overwin-f)

" move to {char}{char}
map <leader>f <Plug>(easymotion-bd-f2)
nmap <leader>f <Plug>(easymotion-overwin-f2)

" move to word
map <leader>F <Plug>(easymotion-bd-w)
nmap <leader>F <Plug>(easymotion-overwin-w)

" move to line
map <leader>g <Plug>(easymotion-bd-jk)
nmap <leader>g <Plug>(easymotion-overwin-line)

" incsearch.vim,incsearch-easymotion.vim依存のコード
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<C-e>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))

" incsearch.vim,incsearch-fuzzy.vim,incsearch-easymotion.vim依存のコード
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<C-e>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <leader>/ incsearch#go(<SID>config_easyfuzzymotion())

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
