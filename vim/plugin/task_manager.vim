"" FILE: task_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:create_task() abort
  " デフォルト値の設定
  if !exists('g:task_manager_root_dir')
    let g:task_manager_root_dir = '~/works/memolist/'
  endif

  if !exists('g:task_manager_dir_prefix')
    let g:task_manager_dir_prefix = '%Y%m%d'
  endif

  " ディレクトリ名の入力を促す
  let l:dir_name = input('Enter directory name: ')
  if empty(l:dir_name)
    echo 'Directory name cannot be empty.'
    return
  endif

  " 日付プレフィックスと組み合わせてディレクトリ名を作成
  let l:date_prefix = strftime(g:task_manager_dir_prefix)
  let l:full_dir_name = l:date_prefix . '_' . l:dir_name

  " フルパスの作成
  let l:root_dir = expand(g:task_manager_root_dir)
  let l:full_dir_path = l:root_dir . '/' . l:full_dir_name

  " ディレクトリの作成
  if !isdirectory(l:full_dir_path)
    call mkdir(l:full_dir_path, 'p')
  endif

  " ファイル名の入力を促す
  let l:file_name = input('Enter file name: ')
  if empty(l:file_name)
    echo 'File name cannot be empty.'
    return
  endif

  " ファイルパスの作成
  let l:file_path = l:full_dir_path . '/' . l:file_name

  " ファイルを作成して開く
  execute 'edit ' . fnameescape(l:file_path)

  echo 'Created task: ' . l:full_dir_name . '/' . l:file_name
endf

command! CreateTask call s:create_task()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
