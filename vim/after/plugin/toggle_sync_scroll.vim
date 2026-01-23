"" FILE: toggle_sync_scroll.vim

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <C-w><Space> :<C-u>ToggleSyncScroll<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
