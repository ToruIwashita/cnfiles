"" FILE: add_git_managed_file_to_buffer.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

nnoremap <leader>tb :<C-u>OpenAllBuffersInTab<CR>
nnoremap <leader>bc :<C-u>AddCToBuffer<CR>
nnoremap <leader>bm :<C-u>AddMToBuffer<CR>
nnoremap <leader>bu :<C-u>AddUToBuffer<CR>
nnoremap <leader>tc :<C-u>AddCToTab<CR>
nnoremap <leader>tm :<C-u>AddMToTab<CR>
nnoremap <leader>tu :<C-u>AddUToTab<CR>
" 全てのバッファを1つのウィンドウで開く
noremap <leader>bb :<C-u>vertical ball<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
