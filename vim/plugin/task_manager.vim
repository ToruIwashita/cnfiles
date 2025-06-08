vim9script

# FILE: task_manager.vim

var cpoptions_save = &cpoptions
set cpoptions&vim

class TaskManager
  var config: dict<string>

  def new()
    # 設定は実行時に読み込むため,ここでは初期化のみ
    this.config = {}
  enddef

  def CreateTask()
    # 実行時に設定を読み込み
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var dir_name = input('Enter dir name: ')
    if empty(dir_name)
      echo 'Dir name cannot be empty.'
      return
    endif

    var full_dir_path = this._BuildDirPath(dir_name)
    if !isdirectory(full_dir_path)
      mkdir(full_dir_path, 'p')
    endif

    var input_file_name = input('Enter file name: ')
    var file_name = this._DetermineFileName(input_file_name, dir_name)

    var full_file_path = this._BuildFilePath(full_dir_path, file_name)
    var file_exists = filereadable(full_file_path)

    this._OpenFileInAppropriateBuffer(full_file_path)

    var display_name = fnamemodify(full_dir_path, ':t') .. '/' .. fnamemodify(full_file_path, ':t')
    if file_exists
      echo 'Opened existing file: ' .. display_name
    else
      this._ShowNotification('Created task: ' .. display_name)
    endif
  enddef

  def _LoadConfig()
    this.config = {
      'root_dir': exists('g:task_manager_root_dir') ? g:task_manager_root_dir : '',
      'dir_prefix': exists('g:task_manager_dir_prefix') ? g:task_manager_dir_prefix : '%Y-%m-%d',
      'default_extension': '.md'
    }
  enddef

  def _ValidateConfig(): bool
    if empty(this.config.root_dir)
      echohl ErrorMsg
      echo 'Error: g:task_manager_root_dir is not set. Please configure it in your vimrc.'
      echohl None
      return false
    endif
    return true
  enddef

  def _BuildDirPath(dir_name: string): string
    var full_dir_name = strftime(this.config.dir_prefix) .. '_' .. dir_name
    return substitute(expand(this.config.root_dir), '/$', '', '') .. '/' .. full_dir_name
  enddef

  def _DetermineFileName(input_name: string, dir_name: string): string
    if empty(input_name)
      return dir_name .. '_instructions'
    else
      return input_name
    endif
  enddef

  def _IsCurrentBufferEmpty(): bool
    return bufname('%') ==# '' && !&modified
  enddef

  def _OpenFileInAppropriateBuffer(file_path: string)
    if this._IsCurrentBufferEmpty()
      execute 'edit ' .. fnameescape(file_path)
    else
      execute 'tabedit ' .. fnameescape(file_path)
    endif
  enddef

  def _BuildFilePath(dir_path: string, file_name: string): string
    var file_name_with_ext = file_name
    if fnamemodify(file_name, ':e') ==# ''
      file_name_with_ext = file_name .. this.config.default_extension
    endif
    return dir_path .. '/' .. file_name_with_ext
  enddef

  def _ShowNotification(message: string)
    var msg_width = strdisplaywidth(message)

    # 現在のウィンドウの位置とサイズを取得
    var win_pos = win_screenpos(0)
    var win_height = winheight(0)
    var win_width = winwidth(0)

    # 現在のウィンドウの中央に表示するための座標計算
    var popup_line = win_pos[0] + (win_height / 2) - 2
    var popup_col = win_pos[1] + (win_width / 2) - (msg_width / 2)

    popup_notification(message, {
      'time': 5000,
      'highlight': 'ModeMsg',
      'line': popup_line,
      'col': popup_col,
      'padding': [0, 1, 0, 1],
      'minwidth': msg_width,
      'maxwidth': msg_width
    })
  enddef
endclass

var task_manager = TaskManager.new()

# 後方互換性のための関数ラッパー
def CreateTaskCommand()
  task_manager.CreateTask()
enddef

command! CreateTask call CreateTaskCommand()

&cpoptions = cpoptions_save
