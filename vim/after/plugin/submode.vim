"" FILE: submode.vim
let s:cpo_save = &cpo
set cpo&vim

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

let &cpo = s:cpo_save
unlet s:cpo_save
