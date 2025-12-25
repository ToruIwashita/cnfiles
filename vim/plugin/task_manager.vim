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
    var OnFinish = (file_was_created: bool = true) => {
      if file_was_created
        this._ShowNotification('Created task: ' .. display_name)
      else
        this._ShowNotification('Created directory: ' .. fnamemodify(full_dir_path, ':t') .. '/')
      endif
    }
    this._ApplyTemplateIfAvailable(full_file_path, OnFinish)
  enddef

  def AppendTask(dir_name: string)
    if empty(dir_name)
      echohl ErrorMsg
      echo 'Error: AppendTask requires a directory name'
      echohl None
      return
    endif

    # 実行時に設定を読み込み
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    # ディレクトリ存在確認
    if !this._ValidateDirectoryExists(dir_name)
      return
    endif

    # latest_ファイル検索
    var root_dir = substitute(expand(this.config.root_dir), '/$', '', '')
    var dir_path = root_dir .. '/' .. dir_name
    var latest_file = this._FindLatestFile(dir_path)

    if empty(latest_file)
      echohl ErrorMsg
      echo 'Error: No latest_ file found in directory "' .. dir_name .. '"'
      echohl None
      return
    endif

    # テンプレート選択とファイル処理のコールバック
    var OnTemplateSelected = (selected_template) => {
      # リネーム前にファイル名を保存
      var original_file_name = fnamemodify(latest_file, ':t')

      # latest_ファイルの未保存変更をディスクに保存
      this._SaveBufferIfModified(latest_file)

      # latest_ファイルをバージョン名にリネーム
      var renamed_path = this._RenameLatestFile(dir_path, latest_file)
      if empty(renamed_path)
        return
      endif

      # 既にlatest_ファイルを表示しているウィンドウをリネーム後のパスに切り替える
      this._SwitchWindowsToFile(latest_file, renamed_path)

      # テンプレートが選択されなかった場合（キャンセル時）
      if empty(selected_template)
        var renamed_display = fnamemodify(dir_path, ':t') .. '/' .. fnamemodify(renamed_path, ':t')
        this._ShowNotification('Renamed: ' .. renamed_display)
        return
      endif

      # 新しいlatest_ファイルを作成（連番を付与）
      var next_number = this._GetNextSequenceNumber(dir_path)

      if next_number > 99
        echohl ErrorMsg
        echo 'Error: Task sequence number cannot exceed 99'
        echohl None
        return
      endif

      var base_name = substitute(original_file_name, '^\d\{2\}_', '', '')
      var new_file_name = this._GenerateNumberedFileName(next_number, base_name)
      var new_latest_path = dir_path .. '/' .. new_file_name

      if selected_template == 'NO_TEMPLATE'
        # [No template]選択時は空ファイルを作成
        writefile([], new_latest_path)
      else
        # テンプレート適用
        this._ApplyTemplate(selected_template, new_latest_path, false)
        # AppendTaskでは既存ファイルの最大番号をベースにプレースホルダ置換
        var max_number = this._GetNextSequenceNumber(dir_path) - 1
        this._ProcessPlaceholders(new_latest_path, max_number)
      endif

      this._OpenFileInAppropriateBuffer(new_latest_path)

      # カーソルをファイル先頭に移動
      if bufname('%') ==# fnameescape(new_latest_path)
        normal! gg
      endif

      var display_name = fnamemodify(dir_path, ':t') .. '/' .. new_file_name
      var renamed_display = fnamemodify(dir_path, ':t') .. '/' .. fnamemodify(renamed_path, ':t')

      this._ShowNotification('Superseded: ' .. display_name)
    }

    # テンプレート選択
    if empty(this.config.template_dir)
      OnTemplateSelected('')
      return
    endif

    var expanded_template_dir = expand(this.config.template_dir)

    if !isdirectory(expanded_template_dir)
      OnTemplateSelected('')
      return
    endif

    var template_files = this._GetTemplateFiles(expanded_template_dir)

    if empty(template_files)
      OnTemplateSelected('')
      return
    endif

    this._SelectTemplate(template_files, OnTemplateSelected)
  enddef

  def CopyTask(dir_name: string)
    if empty(dir_name)
      echohl ErrorMsg
      echo 'Error: CopyTask requires a directory name'
      echohl None
      return
    endif

    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    if !this._ValidateDirectoryExists(dir_name)
      return
    endif

    var default_new_name = this._RebuildDirNameWithTodayPrefix(dir_name)
    var new_dir_name = this._GetCopyTargetDirName(default_new_name)
    if empty(new_dir_name)
      return
    endif

    var root_dir = this._GetCleanRootDir()
    var source_path = root_dir .. '/' .. dir_name
    var target_path = root_dir .. '/' .. new_dir_name

    # コピー先が既に存在する場合はエラー
    if isdirectory(target_path)
      echohl ErrorMsg
      echo 'Error: Directory "' .. new_dir_name .. '" already exists'
      echohl None
      return
    endif

    # タスク名部分を抽出（ファイル名置換用）
    var source_task_body = this._ExtractTaskBodyFromDirName(dir_name)
    var target_task_body = this._ExtractTaskBodyFromDirName(new_dir_name)

    if this._CopyDirectoryExcludingSwap(source_path, target_path, source_task_body, target_task_body)
      this._ShowNotification('Copied: ' .. dir_name .. ' -> ' .. new_dir_name)
    else
      echohl ErrorMsg
      echo 'Error: Failed to copy directory'
      echohl None
    endif
  enddef

  def ArchiveTask(dir_name: string)
    if empty(dir_name)
      echohl ErrorMsg
      echo 'Error: ArchiveTask requires a directory name'
      echohl None
      return
    endif

    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    if !this._ValidateDirectoryExists(dir_name)
      return
    endif

    var archives_dir = this._GetArchivesDir()

    if !isdirectory(archives_dir)
      try
        mkdir(archives_dir, 'p')
      catch
        echohl ErrorMsg
        echo 'Error: Failed to create archives directory: ' .. v:exception
        echohl None
        return
      endtry
      if !isdirectory(archives_dir)
        echohl ErrorMsg
        echo 'Error: Failed to create archives directory'
        echohl None
        return
      endif
    endif

    var root_dir = this._GetCleanRootDir()
    var source_path = root_dir .. '/' .. dir_name
    var target_path = archives_dir .. '/' .. dir_name

    if isdirectory(target_path)
      echohl ErrorMsg
      echo 'Error: Directory "' .. dir_name .. '" already exists in archives'
      echohl None
      return
    endif

    this._CleanupBuffersBeforeMove(source_path)

    if rename(source_path, target_path) == 0
      this._CleanupBuffersAfterMove(source_path, target_path)
      this._ShowNotification('Archived: ' .. dir_name)
    else
      echohl ErrorMsg
      echo 'Error: Failed to archive directory'
      echohl None
    endif
  enddef

  def RestoreTask(dir_name: string)
    if empty(dir_name)
      echohl ErrorMsg
      echo 'Error: RestoreTask requires a directory name'
      echohl None
      return
    endif

    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var archives_dir = this._GetArchivesDir()
    var source_path = archives_dir .. '/' .. dir_name

    if !isdirectory(source_path)
      echohl ErrorMsg
      echo 'Error: Directory "' .. dir_name .. '" not found in archives'
      echohl None
      return
    endif

    var root_dir = this._GetCleanRootDir()
    var target_path = root_dir .. '/' .. dir_name

    if isdirectory(target_path)
      echohl ErrorMsg
      echo 'Error: Directory "' .. dir_name .. '" already exists in task directory'
      echohl None
      return
    endif

    this._CleanupBuffersBeforeMove(source_path)

    if rename(source_path, target_path) == 0
      this._CleanupBuffersAfterMove(source_path, target_path)
      this._ShowNotification('Restored: ' .. dir_name)
    else
      echohl ErrorMsg
      echo 'Error: Failed to restore directory'
      echohl None
    endif
  enddef

  def DeleteTask(dir_name: string)
    if empty(dir_name)
      echohl ErrorMsg
      echo 'Error: DeleteTask requires a directory name'
      echohl None
      return
    endif

    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var archives_dir = this._GetArchivesDir()
    var target_path = archives_dir .. '/' .. dir_name

    if !isdirectory(target_path)
      echohl ErrorMsg
      echo 'Error: Directory "' .. dir_name .. '" not found in archives'
      echohl None
      return
    endif

    this._CleanupBuffersBeforeMove(target_path)

    if delete(target_path, 'rf') == 0
      this._ShowNotification('Deleted: ' .. dir_name)
    else
      echohl ErrorMsg
      echo 'Error: Failed to delete directory'
      echohl None
    endif
  enddef

  def GetDirectoryList(filter_text: string): list<string>
    this._LoadConfig()
    if !this._ValidateConfig()
      return []
    endif

    var root_dir = this._GetCleanRootDir()
    var pattern = root_dir .. '/*'
    var all_paths = glob(pattern, false, true)
    var directories = filter(all_paths, 'isdirectory(v:val)')
    var dir_names = map(directories, 'fnamemodify(v:val, ":t")')

    if empty(filter_text)
      return dir_names
    endif

    var escaped_filter = escape(filter_text, '.*[]^$\\')
    var pattern_regex = '^' .. escaped_filter .. '.*'
    return filter(dir_names, (_, v) => v =~# pattern_regex)
  enddef

  def GetArchiveDirectoryList(filter_text: string): list<string>
    this._LoadConfig()
    if !this._ValidateConfig()
      return []
    endif

    var archives_dir = this._GetArchivesDir()
    if !isdirectory(archives_dir)
      return []
    endif

    var pattern = archives_dir .. '/*'
    var all_paths = glob(pattern, false, true)
    var directories = filter(all_paths, 'isdirectory(v:val)')
    var dir_names = map(directories, 'fnamemodify(v:val, ":t")')

    if empty(filter_text)
      return dir_names
    endif

    var escaped_filter = escape(filter_text, '.*[]^$\\')
    var pattern_regex = '^' .. escaped_filter .. '.*'
    return filter(dir_names, (_, v) => v =~# pattern_regex)
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

    if stridx(this.config.dir_prefix, '_') >= 0
      echohl ErrorMsg
      echo 'Error: g:task_manager_dir_prefix must not contain "_". It is used as a delimiter.'
      echohl None
      return false
    endif

    return true
  enddef

  def _BuildDirPath(dir_name: string): string
    var full_dir_name = strftime(this.config.dir_prefix) .. '_' .. dir_name
    return this._GetCleanRootDir() .. '/' .. full_dir_name
  enddef

  def _RebuildDirNameWithTodayPrefix(dir_name: string): string
    var parts = split(dir_name, '_', true)
    var dir_body = join(parts[1 :], '_')
    var today_prefix = strftime(this.config.dir_prefix)
    return today_prefix .. '_' .. dir_body
  enddef

  def _ExtractTaskBodyFromDirName(dir_name: string): string
    # ディレクトリ名からタスク名部分を抽出
    # 例: "2025-12-25_testタスク" → "testタスク"
    var parts = split(dir_name, '_', true)
    return join(parts[1 :], '_')
  enddef

  def _DetermineFileName(input_name: string, dir_name: string): string
    if empty(input_name)
      return '00_latest_' .. dir_name .. '_instructions'
    else
      return '00_latest_' .. input_name
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
      OnCompletion(false)
      return
    endif

    var expanded_template_dir = expand(this.config.template_dir)
    if !isdirectory(expanded_template_dir)
      OnCompletion(false)
      return
    endif

    var template_files = this._GetTemplateFiles(expanded_template_dir)
    if empty(template_files)
      OnCompletion(false)
      return
    endif

    # テンプレート選択後の処理をコールバックとして渡す
    this._SelectTemplate(template_files, (selected_template) => {
      if selected_template == 'NO_TEMPLATE'
        # [No template]選択時は空ファイルを作成
        writefile([], target_file_path)
        # ファイルが既にバッファに読み込まれている場合は再読み込み
        if bufname('%') ==# fnameescape(target_file_path)
          execute 'edit! ' .. fnameescape(target_file_path)
          normal! gg
        endif
        OnCompletion(true)
      elseif !empty(selected_template)
        this._ApplyTemplate(selected_template, target_file_path)
        # CreateTaskではプレースホルダをデフォルト値で置換（base_number = 0）
        this._ProcessPlaceholders(target_file_path, 0)
        # ファイルが既にバッファに読み込まれている場合は再読み込み
        if bufname('%') ==# fnameescape(target_file_path)
          execute 'edit! ' .. fnameescape(target_file_path)
          normal! gg
        endif
        OnCompletion(true)
      else
        # キャンセル時
        OnCompletion(false)
      endif
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
      if result == 1
        # [No template] を選択
        OnSelect('NO_TEMPLATE')
      elseif result <= 0
        # キャンセル(ESC)した場合
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

  def _ApplyTemplate(template_path: string, target_path: string, open_in_current_buffer: bool = true)
    if filereadable(template_path)
      var template_content = readfile(template_path)
      writefile(template_content, target_path)
      if open_in_current_buffer && !empty(target_path)
        execute 'edit! ' .. fnameescape(target_path)
      endif
    endif
  enddef

  def _SaveBufferIfModified(file_path: string)
    var buf = bufnr(file_path)
    if buf > 0 && getbufvar(buf, '&modified')
      var lines = getbufline(buf, 1, '$')
      writefile(lines, file_path)
    endif
  enddef

  def _SwitchWindowsToFile(old_path: string, new_path: string)
    var buf = bufnr(old_path)
    if buf <= 0
      return
    endif
    for winid in win_findbuf(buf)
      win_execute(winid, 'edit! ' .. fnameescape(new_path))
    endfor
  enddef

  def _CleanupBuffersBeforeMove(dir_path: string)
    var absolute_dir_path = fnamemodify(dir_path, ':p')
    var buffer_path_pattern = '^' .. escape(absolute_dir_path, '.*[]^$\\') .. '/'

    for buffer_number in range(1, bufnr('$'))
      if !bufexists(buffer_number) || empty(bufname(buffer_number))
        continue
      endif

      var buffer_absolute_path = fnamemodify(bufname(buffer_number), ':p')
      if buffer_absolute_path !~# buffer_path_pattern
        continue
      endif

      # 変更があるファイルを保存
      if getbufvar(buffer_number, '&modified')
        execute(buffer_number .. 'bufdo silent! update')
      endif
    endfor
  enddef

  def _CleanupBuffersAfterMove(old_dir_path: string, new_dir_path: string)
    this._CleanupBuffersForPath(old_dir_path)
    this._CleanupBuffersForPath(new_dir_path)

    var absolute_new_dir_path = fnamemodify(new_dir_path, ':p')
    var hidden_swp_pattern = absolute_new_dir_path .. '**/.*.swp'
    var swp_files_to_delete = glob(hidden_swp_pattern, false, true)
    for swp_file_path in swp_files_to_delete
      if filereadable(swp_file_path)
        call delete(swp_file_path)
      endif
    endfor
  enddef

  def _CleanupBuffersForPath(dir_path: string)
    var absolute_dir_path = fnamemodify(dir_path, ':p')
    var buffer_path_pattern = '^' .. escape(absolute_dir_path, '.*[]^$\\') .. '/'

    for buffer_number in range(1, bufnr('$'))
      if !bufexists(buffer_number) || empty(bufname(buffer_number))
        continue
      endif

      var buffer_absolute_path = fnamemodify(bufname(buffer_number), ':p')
      if buffer_absolute_path !~# buffer_path_pattern
        continue
      endif

      execute 'silent! bwipeout! ' .. buffer_number
    endfor
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
      'time': 1000,
      'highlight': 'ModeMsg',
      'line': popup_line,
      'col': popup_col,
      'padding': [0, 1, 0, 1],
      'minwidth': msg_width,
      'maxwidth': msg_width
    })
  enddef

  def _ValidateDirectoryExists(dir_name: string): bool
    var root_dir = this._GetCleanRootDir()
    var dir_path = root_dir .. '/' .. dir_name
    if !isdirectory(dir_path)
      echohl ErrorMsg
      echo 'Error: Directory "' .. dir_name .. '" not found in task_manager_root_dir'
      echohl None
      return false
    endif
    return true
  enddef

  def _FindLatestFile(dir_path: string): string
    var pattern = dir_path .. '/*_latest_*'
    var files = glob(pattern, false, true)
    if empty(files)
      return ''
    endif
    return files[0]
  enddef

  def _GenerateVersionedFileName(original_name: string): string
    var timestamp = strftime('%Y%m%d-%H%M%S')
    var prefix_number = this._ExtractPrefixNumber(original_name)
    if prefix_number >= 0
      var base_name = substitute(original_name, '^\d\{2\}_latest_', '', '')
      return printf('%02d_v%s_%s', prefix_number, timestamp, base_name)
    else
      return substitute(original_name, '^latest_', 'v' .. timestamp .. '_', '')
    endif
  enddef

  def _RenameLatestFile(dir_path: string, latest_file: string): string
    var versioned_name = this._GenerateVersionedFileName(fnamemodify(latest_file, ':t'))
    var versioned_path = dir_path .. '/' .. versioned_name

    if rename(latest_file, versioned_path) == 0
      return versioned_path
    else
      echohl ErrorMsg
      echo 'Error: Failed to rename file'
      echohl None
      return ''
    endif
  enddef

  def _ExtractPrefixNumber(filename: string): number
    var match_result = matchlist(filename, '^\(\d\{2\}\)_.*')
    if empty(match_result)
      return -1
    endif
    return str2nr(match_result[1])
  enddef

  def _GetNextSequenceNumber(dir_path: string): number
    var pattern = dir_path .. '/*_*'
    var files = glob(pattern, false, true)
    var max_number = -1

    for file_path in files
      var filename = fnamemodify(file_path, ':t')
      var prefix_number = this._ExtractPrefixNumber(filename)
      if prefix_number >= 0 && prefix_number > max_number
        max_number = prefix_number
      endif
    endfor

    return max_number + 1
  enddef

  def _GenerateNumberedFileName(number: number, base_name: string): string
    return printf('%02d_%s', number, base_name)
  enddef

  def _ProcessPlaceholders(file_path: string, base_number: number)
    if !filereadable(file_path)
      return
    endif

    var lines = readfile(file_path)
    var modified = false

    for i in range(len(lines))
      var original_line = lines[i]
      # パターンを`<数字:数字>`に修正（バッククォートを含む）
      var new_line = substitute(original_line, '<`\(\d\+\):\(0\d\)`>', '\=this._CalculatePlaceholderValue(submatch(2), base_number)', 'g')
      if new_line !=# original_line
        lines[i] = new_line
        modified = true
      endif
    endfor

    if modified
      writefile(lines, file_path)
    endif
  enddef

  def _CalculatePlaceholderValue(default_value: string, base_number: number): string
    var default_num = str2nr(default_value)
    var result_num = base_number + default_num
    return printf('%02d', result_num)
  enddef

  def _GetCleanRootDir(): string
    var root_dir = substitute(expand(this.config.root_dir), '/$', '', '')
    return substitute(root_dir, '\n\|\r', '', 'g')
  enddef

  def _GetArchivesDir(): string
    return this._GetCleanRootDir() .. '/archived_tasks'
  enddef

  def _GetCopyTargetDirName(default_name: string): string
    var new_name = input('Enter new directory name: ', default_name)
    if !empty(new_name)
      return new_name
    endif

    while true
      redraw

      echohl ErrorMsg
      echo 'Directory name cannot be empty.'
      echohl None
      echo ''

      var retry_name = input('Enter new directory name: ', default_name)
      if !empty(retry_name)
        return retry_name
      endif
    endwhile
    return ''
  enddef

  def _CopyDirectoryExcludingSwap(source_path: string, target_path: string, source_task_body: string = '', target_task_body: string = ''): bool
    try
      # ターゲットディレクトリを作成
      if !isdirectory(target_path)
        mkdir(target_path, 'p')
      endif

      # ソースディレクトリ内の全アイテムを取得（再帰的）
      var all_items = glob(source_path .. '/**', false, true)

      # ディレクトリとファイルを分離
      var directories = []
      var files = []

      for item in all_items
        # .swpファイルをスキップ
        if item =~# '\.sw[a-p]$'
          continue
        endif

        if isdirectory(item)
          add(directories, item)
        else
          # _instructionsを含むファイルのみを対象とする
          var filename = fnamemodify(item, ':t')
          if filename =~# '_instructions'
            add(files, item)
          endif
        endif
      endfor

      # まずディレクトリを作成（ファイルがコピーされるディレクトリのみ）
      for dir_item in directories
        var relative_path = substitute(dir_item, '^' .. escape(source_path, '.*[]^$\\') .. '/', '', '')
        var target_dir = target_path .. '/' .. relative_path
        # このディレクトリ内にコピー対象のファイルがあるかチェック
        var has_target_files = false
        for file_item in files
          if file_item =~# '^' .. escape(dir_item, '.*[]^$\\') .. '/'
            has_target_files = true
            break
          endif
        endfor
        if has_target_files && !isdirectory(target_dir)
          mkdir(target_dir, 'p')
        endif
      endfor

      # 次にファイルをコピー（タスク名部分を置換）
      for file_item in files
        var relative_path = substitute(file_item, '^' .. escape(source_path, '.*[]^$\\') .. '/', '', '')

        # ファイル名内のタスク名部分を置換
        if !empty(source_task_body) && !empty(target_task_body)
          relative_path = substitute(relative_path, escape(source_task_body, '.*[]^$\\'), target_task_body, 'g')
        endif

        var target_file = target_path .. '/' .. relative_path
        var content = readfile(file_item, 'b')
        writefile(content, target_file, 'b')
      endfor

      # コピー先ファイルの接頭辞番号を00から連番に再付番
      this._RenumberFilesInDirectory(target_path)

      return true
    catch
      return false
    endtry
  enddef

  def _RenumberFilesInDirectory(dir_path: string)
    # ディレクトリ内のファイルを取得
    var files = glob(dir_path .. '/*', false, true)
    files = filter(files, '!isdirectory(v:val)')

    # 番号順にソート
    sort(files, (a, b) => {
      var num_a = this._ExtractPrefixNumber(fnamemodify(a, ':t'))
      var num_b = this._ExtractPrefixNumber(fnamemodify(b, ':t'))
      return num_a - num_b
    })

    # 連番でリネーム
    var seq_number = 0
    for file_path in files
      var filename = fnamemodify(file_path, ':t')
      var new_filename = substitute(filename, '^\d\{2\}_', printf('%02d_', seq_number), '')

      if filename !=# new_filename
        var new_path = dir_path .. '/' .. new_filename
        rename(file_path, new_path)
      endif

      seq_number += 1
    endfor
  enddef
endclass

var task_manager = TaskManager.new()

def ActiveTasksComplete(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
  return task_manager.GetDirectoryList(ArgLead)
enddef

def ArchivedTasksComplete(ArgLead: string, CmdLine: string, CursorPos: number): list<string>
  return task_manager.GetArchiveDirectoryList(ArgLead)
enddef

# 後方互換性のための関数ラッパー
def CreateTaskCommand(...args: list<string>)
  if len(args) > 0
    task_manager.CreateTask(args[0])
  else
    task_manager.CreateTask()
  endif
enddef

def AppendTaskCommand(dir_name: string)
  task_manager.AppendTask(dir_name)
enddef

def CopyTaskCommand(dir_name: string)
  task_manager.CopyTask(dir_name)
enddef

def ArchiveTaskCommand(dir_name: string)
  task_manager.ArchiveTask(dir_name)
enddef

def RestoreTaskCommand(dir_name: string)
  task_manager.RestoreTask(dir_name)
enddef

def DeleteTaskCommand(dir_name: string)
  task_manager.DeleteTask(dir_name)
enddef

command! -nargs=? CreateTask call CreateTaskCommand(<f-args>)
command! -nargs=1 -complete=customlist,ActiveTasksComplete AppendTask call AppendTaskCommand(<f-args>)
command! -nargs=1 -complete=customlist,ActiveTasksComplete CopyTask call CopyTaskCommand(<f-args>)
command! -nargs=1 -complete=customlist,ActiveTasksComplete ArchiveTask call ArchiveTaskCommand(<f-args>)
command! -nargs=1 -complete=customlist,ArchivedTasksComplete RestoreTask call RestoreTaskCommand(<f-args>)
command! -nargs=1 -complete=customlist,ArchivedTasksComplete DeleteTask call DeleteTaskCommand(<f-args>)

&cpoptions = cpoptions_save
