scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" quickrun出力完了後(hook-point-exit)にColorizerで色付けを行うhook
" outputter=bufferがwin_execute()でautocmdを発火させずに書き込むためBufWinEnter/WinEnterだけでは間に合わない問題への対策
let s:hook = {
  \ 'name': 'colorize_output_buffer',
  \ 'kind': 'hook',
  \ 'config': {
  \   'enable': 0,
  \   'bufname': 'quickrun://output'
  \ }
\ }

function! s:hook.on_exit(...) abort
  if !exists('*Colorizer#ColorWinEnter')
    return
  endif

  let target_bufnr = bufnr(self.config.bufname)

  if target_bufnr <= 0
    return
  endif

  for winid in win_findbuf(target_bufnr)
    call win_execute(winid, 'call Colorizer#ColorWinEnter(1)')
  endfor
endfunction

function! quickrun#hook#colorize_output_buffer#new() abort
  return deepcopy(s:hook)
endfunction

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
