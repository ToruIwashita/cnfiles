"" FILE: surround.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

if !exists('g:surround_no_mappings') || !g:surround_no_mappings
  " normal
  nmap <leader>( csw(
  nmap <leader>) csw)
  nmap <leader>{ csw{
  nmap <leader>} csw}
  nmap <leader>[ csw[
  nmap <leader>] csw]
  nmap <leader>' csw'
  nmap <leader>" csw"
  nmap <leader>` csw`
  " visual
  xmap <leader>( S(
  xmap <leader>) S)
  xmap <leader>{ S{
  xmap <leader>} S}
  xmap <leader>[ S[
  xmap <leader>] S]
  xmap <leader>' S'
  xmap <leader>" S"
  xmap <leader>` S`
endif

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
