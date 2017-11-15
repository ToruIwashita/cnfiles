"" FILE: EasyMotion.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" move to {char}
map  <C-f>k <Plug>(easymotion-bd-f)
nmap <C-f>k <Plug>(easymotion-overwin-f)

" move to {char}{char}
map <C-f><C-k> <Plug>(easymotion-overwin-f2)
nmap <C-f><C-k> <Plug>(easymotion-overwin-f2)

" move to line
map <C-f>l <Plug>(easymotion-bd-jk)
map <C-f><C-l> <Plug>(easymotion-bd-jk)
nmap <C-f>l <Plug>(easymotion-overwin-line)
nmap <C-f><C-l> <Plug>(easymotion-overwin-line)

" move to word
map  <C-f>j <Plug>(easymotion-bd-w)
map  <C-f><C-j> <Plug>(easymotion-bd-w)
nmap <C-f>j <Plug>(easymotion-overwin-w)
nmap <C-f><C-j> <Plug>(easymotion-overwin-w)

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
