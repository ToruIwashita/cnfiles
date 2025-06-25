" FILE: task_manager.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class TaskManager
  var config: dict<string>

  def new()
    # 設定は実行時に読み込むため,ここでは初期化のみ
    this.config = {}
  enddef

  def CreateTask(dir_name: string = '')
    # 実行時に設定を読み込み
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var actual_dir_name: string
    if empty(dir_name)
      actual_dir_name = this._GetDirNameInput()
      if empty(actual_dir_name)
        return
      endif
    else
      actual_dir_name = dir_name
    endif

    var full_dir_path = this._BuildDirPath(actual_dir_name)
    if !isdirectory(full_dir_path)
      mkdir(full_dir_path, 'p')
    endif

    var input_file_name: string
    if empty(dir_name)
      input_file_name = input('Enter file name: ')
    else
      input_file_name = ''
    endif
    var file_name = this._DetermineFileName(input_file_name, actual_dir_name)

    var full_file_path = this._BuildFilePath(full_dir_path, file_name)
    var file_exists = filereadable(full_file_path)

    this._OpenFileInAppropriateBuffer(full_file_path)

    var display_name = fnamemodify(full_dir_path, ':t') .. '/' .. fnamemodify(full_file_path, ':t')

    if file_exists
      echo 'Opened existing file: ' .. display_name
      return
    endif

    # 新規ファイル作成の場合,テンプレート適用後に作成完了の通知を出す
    var OnFinish = () => {
      this._ShowNotification('Created task: ' .. display_name)
    }
    this._ApplyTemplateIfAvailable(full_file_path, OnFinish)
  enddef

  def _LoadConfig()
    this.config = {
      'root_dir': exists('g:task_manager_root_dir') ? g:task_manager_root_dir : '',
      'dir_prefix': exists('g:task_manager_dir_prefix') ? g:task_manager_dir_prefix : '%Y-%m-%d',
      'default_extension': '.md',
      'template_dir': exists('g:task_manager_instruction_file_template_dir') ? g:task_manager_instruction_file_template_dir : ''
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

  def _ApplyTemplateIfAvailable(target_file_path: string, OnCompletion: func)
    if empty(this.config.template_dir)
      OnCompletion()
      return
    endif

    var expanded_template_dir = expand(this.config.template_dir)
    if !isdirectory(expanded_template_dir)
      OnCompletion()
      return
    endif

    var template_files = this._GetTemplateFiles(expanded_template_dir)
    if empty(template_files)
      OnCompletion()
      return
    endif

    # テンプレート選択後の処理をコールバックとして渡す
    this._SelectTemplate(template_files, (selected_template) => {
      if !empty(selected_template)
        this._ApplyTemplate(selected_template, target_file_path)
      endif
      OnCompletion()
    })
  enddef

  def _GetTemplateFiles(template_dir: string): list<string>
    var normalized_dir = substitute(template_dir, '/$', '', '')
    var template_pattern = normalized_dir .. '/*'
    return glob(template_pattern, false, true)
  enddef

  def _SelectTemplate(template_files: list<string>, OnSelect: func)
    # ポップアップに表示する項目リストを作成
    # fnamemodify(..., ':t') でファイル名のみを抽出
    var display_items = ['[ No template ]']
    for template_file in template_files
      add(display_items, fnamemodify(template_file, ':t'))
    endfor

    # ポップアップが閉じたときに呼び出されるコールバック関数
    var PopupCallback = (id, result) => {
      # result <= 1 は [No template] を選択したか、キャンセル(ESC)した場合
      if result <= 1
        OnSelect('')
      else
        # resultは1 - based index
        # display_itemsの先頭に'No template'を追加しているためtemplate_filesに対応するインデックスはresult - 2となる
        var selected_path = template_files[result - 2]
        OnSelect(selected_path)
      endif
    }

    # カスタムフィルター関数でESCとqを処理
    var PopupFilter = (id, key) => {
      if key == "\<Esc>" || key == 'q'
        # ポップアップを閉じてからコールバックを呼び出す
        popup_close(id, -1)
        return true
      endif
      # その他のキーはデフォルトのメニューフィルターに委譲
      return popup_filter_menu(id, key)
    }

    popup_menu(display_items, {
      'title': 'Select a Template',
      'callback': PopupCallback,
      'line': 'cursor',
      'col': 'cursor',
      'border': [1, 1, 1, 1],
      'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
      'mapping': false, # mappingをfalseにしてPopupFilterに完全に委譲
      'filter': PopupFilter
    })
  enddef

  def _ApplyTemplate(template_path: string, target_path: string)
    if filereadable(template_path)
      var template_content = readfile(template_path)
      writefile(template_content, target_path)
      edit!
    endif
  enddef

  def _GetDirNameInput(): string
    var dir_name = input('Enter dir name: ')
    if !empty(dir_name)
      return dir_name
    endif

    while true
      redraw

      echohl ErrorMsg
      echo 'Dir name cannot be empty.'
      echohl None
      echo ''

      var retry_dir_name = input('Enter dir name: ')
      if !empty(retry_dir_name)
        return retry_dir_name
      endif
    endwhile
    return ''
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
def CreateTaskCommand(...args: list<string>)
  if len(args) > 0
    task_manager.CreateTask(args[0])
  else
    task_manager.CreateTask()
  endif
enddef

command! -nargs=? CreateTask call CreateTaskCommand(<f-args>)

&cpoptions = cpoptions_save
