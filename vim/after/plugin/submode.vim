"" FILE: submode.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" ウィンドウサイズ変更
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')

" タブ移動(動きが重いので<C-w><C-]>,<C-w><C-[>にはmapしない)
call submode#enter_with('changetab', 'n', '', '<C-w>]', 'gt')
call submode#enter_with('changetab', 'n', '', '<C-w>[', 'gT')
call submode#map('changetab', 'n', '', ']', 'gt')
call submode#map('changetab', 'n', '', '[', 'gT')

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
