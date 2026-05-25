"" FILE: Colorizer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" BufLeaveで色クリアするデフォルト挙動を無効化
let g:colorizer_bufleave = 0

" 起動時から全ファイルで自動有効化
" g:colorizer_auto_colorとAutoCmdsはg:colorizer_auto_filetype指定のftでしか動作しないため
" 全ftで色付けするにはforce=1でColorWinEnterを直接呼ぶ
" quickrun出力バッファは別途quickrun-hook(colorize_output_buffer)で対応しているため除外する
function! s:colorize_unless_quickrun_output() abort
  if bufname('%') ==# 'quickrun://output'
    return
  endif

  call Colorizer#ColorWinEnter(1)
endfunction

augroup local_colorizer
  autocmd!
  autocmd BufWinEnter,WinEnter * silent call s:colorize_unless_quickrun_output()
augroup END

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
