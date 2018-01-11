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
  nmap ;s crs
  vmap ;s :<C-u>VisualReplaceSpaceWithChain<CR>:normal crs<CR>
  " change PascalCase
  nmap ;p crm
  vmap ;p :<C-u>VisualReplaceSpaceWithChain<CR>:normal crm<CR>
  " change camelCase
  nmap ;c crc
  vmap ;c :<C-u>VisualReplaceSpaceWithChain<CR>:normal crc<CR>
  " change chain-case
  nmap ;- cr-
  vmap ;- :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr-<CR>
  " change UPPER_CASE
  nmap ;u cru
  vmap ;u :<C-u>VisualReplaceSpaceWithChain<CR>:normal cru<CR>
  " change dot.case
  nmap ;. cr.
  vmap ;. :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr.<CR>
  " change space case
  nmap ;<SPACE> cr<SPACE>
  vmap ;<SPACE> :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr<SPACE><CR>
  " change Title Case
  nmap ;t crt
  vmap ;t :<C-u>VisualReplaceSpaceWithChain<CR>:normal crt<CR>
endif

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
