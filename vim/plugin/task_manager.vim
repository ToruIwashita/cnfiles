"" FILE: task_manager.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:show_popup_notification(message) abort
  let l:msg_width = strdisplaywidth(a:message)

  " 現在のウィンドウの位置とサイズを取得
  let l:win_pos = win_screenpos(0)
  let l:win_height = winheight(0)
  let l:win_width = winwidth(0)

  " 現在のウィンドウの中央に表示するための座標計算
  let l:popup_line = l:win_pos[0] + (l:win_height / 2) - 2
  let l:popup_col = l:win_pos[1] + (l:win_width / 2) - (l:msg_width / 2)

  call popup_notification(a:message, {
    \ 'time': 5000,
    \ 'highlight': 'ModeMsg',
    \ 'line': l:popup_line,
    \ 'col': l:popup_col,
    \ 'padding': [0, 1, 0, 1],
    \ 'minwidth': l:msg_width,
    \ 'maxwidth': l:msg_width
  \ })
endf

fun! s:create_task() abort
  if !exists('g:task_manager_root_dir')
    echohl ErrorMsg
    echo 'Error: g:task_manager_root_dir is not set. Please configure it in your vimrc.'
    echohl None
    return
  endif

  if !exists('g:task_manager_dir_prefix')
    let g:task_manager_dir_prefix = '%Y-%m-%d'
  endif

  let l:dir_name = input('Enter dir name: ')

  if empty(l:dir_name)
    echo 'Dir name cannot be empty.'
    return
  endif

  " 日付プレフィックスと組み合わせてディレクトリ名を作成
  let l:full_dir_name = strftime(g:task_manager_dir_prefix) . '_' . l:dir_name
  " ディレクトリのフルパス作成
  let l:full_dir_path = substitute(expand(g:task_manager_root_dir), '/$', '', '') . '/' . l:full_dir_name

  if !isdirectory(l:full_dir_path)
    call mkdir(l:full_dir_path, 'p')
  endif

  let l:file_name = input('Enter file name: ')
  if empty(l:file_name)
    echo 'File name cannot be empty.'
    return
  endif

  " ファイルのフルパス作成（拡張子がない場合は.mdを追加）
  if fnamemodify(l:file_name, ':e') ==# ''
    let l:file_name_with_ext = l:file_name . '.md'
  else
    let l:file_name_with_ext = l:file_name
  endif

  let l:full_file_path = l:full_dir_path . '/' . l:file_name_with_ext

  " ファイルが既に存在するかチェック
  let l:file_exists = filereadable(l:full_file_path)

  execute 'edit ' . fnameescape(l:full_file_path)

  if l:file_exists
    echo 'Opened existing file: ' . l:full_dir_name . '/' . l:file_name_with_ext
  else
    " 新規ファイルの場合はpopupで通知
    call s:show_popup_notification('Created task: ' . l:full_dir_name . '/' . l:file_name_with_ext)
  endif
endf

command! CreateTask call s:create_task()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
