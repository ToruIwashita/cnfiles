"" FILE: task_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" タスク管理のルートディレクトリ
let g:task_manager_root_dir = g:memolist_dir_path

" 作成するディレクトリのプレフィックス（日付）
let g:task_manager_dir_prefix = '%Y-%m-%d'

" テンプレートディレクトリの指定
let g:task_manager_instruction_file_template_dir = g:agentic_coding_task_template_dir_path

nnoremap <leader>W :<C-u>CopyTask<SPACE><C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <leader>T :<C-u>CreateTask<SPACE>
nnoremap <leader>A :<C-u>AppendTask<SPACE><C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <leader>K :<C-u>ArchiveTask<SPACE><C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <leader>E :<C-u>DeleteTask<SPACE><C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <leader>R :<C-u>RestoreTask<SPACE><C-R>=strftime('%Y-%m-%d')<CR>

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
