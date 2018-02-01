"" FILE: abolish.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

if !exists('g:abolish_no_mappings') || !g:abolish_no_mappings
  fun! s:visual_replace_space_with_chain() range
    let l:pos = getpos('.')

    execute "'<,'>s/\\%V /-/g"
    call setpos('.', l:pos)
  endf

  command! -range VisualReplaceSpaceWithChain call s:visual_replace_space_with_chain()

  " change snake_case
  nmap <leader>,s crs
  vmap <leader>,s :<C-u>VisualReplaceSpaceWithChain<CR>:normal crs<CR>
  " change PascalCase
  nmap <leader>,p crm
  vmap <leader>,p :<C-u>VisualReplaceSpaceWithChain<CR>:normal crm<CR>
  " change camelCase
  nmap <leader>,c crc
  vmap <leader>,c :<C-u>VisualReplaceSpaceWithChain<CR>:normal crc<CR>
  " change chain-case
  nmap <leader>,- cr-
  vmap <leader>,- :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr-<CR>
  " change UPPER_CASE
  nmap <leader>,u cru
  vmap <leader>,u :<C-u>VisualReplaceSpaceWithChain<CR>:normal cru<CR>
  " change dot.case
  nmap <leader>,. cr.
  vmap <leader>,. :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr.<CR>
  " change space case
  nmap <leader>,<SPACE> cr<SPACE>
  vmap <leader>,<SPACE> :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr<SPACE><CR>
  " change Title Case
  nmap <leader>,t crt
  vmap <leader>,t :<C-u>VisualReplaceSpaceWithChain<CR>:normal crt<CR>
endif

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
