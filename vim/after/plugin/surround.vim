"" FILE: surround.vim
let s:cpo_save = &cpo
set cpo&vim

if !exists("g:surround_no_mappings") || ! g:surround_no_mappings
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

let &cpo = s:cpo_save
unlet s:cpo_save
