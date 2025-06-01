"" FILE: task_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" タスク管理のルートディレクトリ
let g:task_manager_root_dir = '~/works/memolist/'

" 日付のフォーマット（年月日）
let g:task_manager_dir_prefix = '%Y%m%d'

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save 