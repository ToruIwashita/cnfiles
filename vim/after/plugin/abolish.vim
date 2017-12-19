"" FILE: abolish.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

if !exists('g:abolish_no_mappings') || !g:abolish_no_mappings
  " change snake_case
  nmap ccs crs
  " change PascalCase
  nmap ccp crm
  " change camelCase
  nmap ccc crc
  " change UPPER_CASE
  nmap ccu cru
  " change dash-case
  nmap cc- cr-
  " change dot.case
  nmap cc. cr.
  " change space case
  nmap cc<SPACE> cr<SPACE>
  " change Title Case
  nmap cct crt
endif

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
