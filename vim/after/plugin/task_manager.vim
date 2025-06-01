"" FILE: task_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" タスク管理のルートディレクトリ
let g:task_manager_root_dir = g:memolist_dir_path

" 作成するディレクトリのプレフィックス（日付）
let g:task_manager_dir_prefix = '%Y%m%d'

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save 
