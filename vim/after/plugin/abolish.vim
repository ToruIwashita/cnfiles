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
  nmap ccs crs
  vmap ccs :<C-u>VisualReplaceSpaceWithChain<CR>:normal crs<CR>
  " change PascalCase
  nmap ccp crm
  vmap ccp :<C-u>VisualReplaceSpaceWithChain<CR>:normal crm<CR>
  " change camelCase
  nmap ccc crc
  vmap ccc :<C-u>VisualReplaceSpaceWithChain<CR>:normal crc<CR>
  " change chain-case
  nmap cc- cr-
  vmap cc- :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr-<CR>
  " change UPPER_CASE
  nmap ccu cru
  vmap ccu :<C-u>VisualReplaceSpaceWithChain<CR>:normal cru<CR>
  " change dot.case
  nmap cc. cr.
  vmap cc. :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr.<CR>
  " change space case
  nmap cc<SPACE> cr<SPACE>
  vmap cc<SPACE> :<C-u>VisualReplaceSpaceWithChain<CR>:normal cr<SPACE><CR>
  " change Title Case
  nmap cct crt
  vmap cct :<C-u>VisualReplaceSpaceWithChain<CR>:normal crt<CR>
endif

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
