" FILE: pbcopy_manager.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class PbcopyManager
  var config: dict<string>

  def new()
    # 設定は実行時に読み込むため,ここでは初期化のみ
    this.config = {}
  enddef

  def CopyBufferToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    execute ':w !' .. this.config.pbcopy_command
    redraw!
    echo 'Buffer copied to clipboard'
  enddef

  def CopyFilePathToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    write

    var full_path = expand('%:p')
    var display_path = this._GetDisplayPath(full_path)

    this._ExecutePbcopy(display_path, 'Copied to clipboard: ' .. display_path)
  enddef

  def CopyFileNameToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    write

    var file_name = expand('%:t')

    this._ExecutePbcopy(file_name, 'Copied to clipboard: ' .. file_name)
  enddef

  def CopyDirPathToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    write

    var dir_path = expand('%:p:h')
    var display_path = this._GetDisplayPath(dir_path)

    this._ExecutePbcopy(display_path, 'Copied to clipboard: ' .. display_path)
  enddef

  def CopyWordToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var word = expand('<cword>')
    if empty(word)
      echohl ErrorMsg
      echo 'No word under cursor'
      echohl None
      return
    endif

    # ヤンクレジスタにも保存
    setreg('"', word)

    # pbcopyでクリップボードにもコピー
    this._ExecutePbcopy(word, 'Copied word to clipboard')
  enddef

  def CopySelectionToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var selection_info = this._GetSelectionInfo()
    if empty(selection_info.content)
      echohl ErrorMsg
      echo 'No selection found'
      echohl None
      return
    endif

    # ヤンクレジスタにも保存
    setreg('"', selection_info.content)

    # pbcopyでクリップボードにもコピー
    this._ExecutePbcopy(selection_info.content, 'Copied selection to clipboard')
  enddef

  def CopySelectionWithPathToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var selection_info = this._GetSelectionInfo()
    if empty(selection_info.content)
      echohl ErrorMsg
      echo 'No selection found'
      echohl None
      return
    endif

    var full_path = expand('%:p')
    var display_path = this._GetDisplayPath(full_path)
    var formatted_content = this._FormatSelectionWithPath(
      selection_info.content,
      display_path,
      selection_info.start_line,
      selection_info.end_line
    )

    # ヤンクレジスタにも保存
    setreg('"', formatted_content)

    # pbcopyでクリップボードにもコピー
    var line_range = selection_info.start_line == selection_info.end_line ? string(selection_info.start_line) : selection_info.start_line .. '-' .. selection_info.end_line
    this._ExecutePbcopy(formatted_content, 'Copied selection with path to clipboard: ' .. display_path .. ':' .. line_range)
  enddef

  def CopyWrappedSelectionWithPathToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var selection_info = this._GetSelectionInfo()
    if empty(selection_info.content)
      echohl ErrorMsg
      echo 'No selection found'
      echohl None
      return
    endif

    var full_path = expand('%:p')
    var display_path = this._GetDisplayPath(full_path)
    var formatted_content = this._FormatSelectionWithPathWrapped(
      selection_info.content,
      display_path,
      selection_info.start_line,
      selection_info.end_line
    )

    # ヤンクレジスタにも保存
    setreg('"', formatted_content)

    # pbcopyでクリップボードにもコピー
    var line_range = selection_info.start_line == selection_info.end_line ? string(selection_info.start_line) : selection_info.start_line .. '-' .. selection_info.end_line
    this._ExecutePbcopy(formatted_content, 'Copied wrapped selection with path to clipboard: ' .. display_path .. ':' .. line_range)
  enddef

  def CopyFilePathWithLineToClipboard()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    var current_line = line('.')
    var full_path = expand('%:p')
    var display_path = this._GetDisplayPath(full_path)
    var path_ref = display_path .. ':' .. current_line

    # ヤンクレジスタにも保存
    setreg('"', path_ref)

    # pbcopyでクリップボードにもコピー
    this._ExecutePbcopy(path_ref, 'Copied path reference to clipboard: ' .. path_ref)
  enddef

  def _LoadConfig()
    this.config = {
      'pbcopy_command': 'pbcopy'
    }
  enddef

  def _ValidateConfig(): bool
    if !executable(this.config.pbcopy_command)
      echohl ErrorMsg
      echo 'Error: pbcopy command not found'
      echohl None
      return false
    endif
    return true
  enddef

  def _GetDisplayPath(full_path: string): string
    var home = expand('~')
    if full_path =~# '^' .. home
      return substitute(full_path, '^' .. home, '~', '')
    else
      return full_path
    endif
  enddef

  def _GetSelectionInfo(): dict<any>
    var start_pos = getpos("'<")
    var end_pos = getpos("'>")

    if start_pos[1] == 0 || end_pos[1] == 0
      return {
        'content': '',
        'start_line': 0,
        'end_line': 0
      }
    endif

    # visualmode()は直前のビジュアルモード種別を返す（v/V/Ctrl-V）
    # mode()だとコマンド実行時には'n'になってしまうためvisualmode()を使用
    var raw_vis_mode = visualmode()

    # visualmode()が空の場合は文字選択モードをデフォルトとする
    var vis_mode: string
    if raw_vis_mode == ''
      vis_mode = 'v'
    else
      vis_mode = raw_vis_mode
    endif

    # getregion()で選択範囲を直接取得
    var selected_lines = getregion(start_pos, end_pos, {'type': vis_mode})

    if empty(selected_lines)
      return {
        'content': '',
        'start_line': start_pos[1],
        'end_line': end_pos[1]
      }
    endif

    return {
      'content': join(selected_lines, "\n"),
      'start_line': start_pos[1],
      'end_line': end_pos[1]
    }
  enddef

  def _FormatSelectionWithPath(content: string, file_path: string, start_line: number, end_line: number): string
    var line_range = start_line == end_line ? string(start_line) : start_line .. '-' .. end_line
    return '@' .. file_path .. ':' .. line_range .. "\n\n" .. content
  enddef

  def _FormatSelectionWithPathWrapped(content: string, file_path: string, start_line: number, end_line: number): string
    var line_range = start_line == end_line ? string(start_line) : start_line .. '-' .. end_line
    return "---\n" .. '@' .. file_path .. ':' .. line_range .. "\n\n" .. content .. "\n---"
  enddef

  def _ExecutePbcopy(content: string, message: string)
    var result = system(this.config.pbcopy_command, content)
    if v:shell_error != 0
      echohl ErrorMsg
      echo 'Error: Failed to copy to clipboard'
      echohl None
      return
    endif
    redraw!
    echo message
  enddef
endclass

var pbcopy_manager = PbcopyManager.new()

# 後方互換性のための関数ラッパー
def CopyBufferToClipboardCommand()
  pbcopy_manager.CopyBufferToClipboard()
enddef

def CopyFilePathToClipboardCommand()
  pbcopy_manager.CopyFilePathToClipboard()
enddef

def CopyFileNameToClipboardCommand()
  pbcopy_manager.CopyFileNameToClipboard()
enddef

def CopyDirPathToClipboardCommand()
  pbcopy_manager.CopyDirPathToClipboard()
enddef

def CopyWordToClipboardCommand()
  pbcopy_manager.CopyWordToClipboard()
enddef

def CopySelectionToClipboardCommand()
  pbcopy_manager.CopySelectionToClipboard()
enddef

def CopySelectionWithPathToClipboardCommand()
  pbcopy_manager.CopySelectionWithPathToClipboard()
enddef

def CopyWrappedSelectionWithPathToClipboardCommand()
  pbcopy_manager.CopyWrappedSelectionWithPathToClipboard()
enddef

def CopyFilePathWithLineToClipboardCommand()
  pbcopy_manager.CopyFilePathWithLineToClipboard()
enddef

command! CopyBufferToClipboard call CopyBufferToClipboardCommand()
command! CopyFilePathToClipboard call CopyFilePathToClipboardCommand()
command! CopyFileNameToClipboard call CopyFileNameToClipboardCommand()
command! CopyDirPathToClipboard call CopyDirPathToClipboardCommand()
command! CopyWordToClipboard call CopyWordToClipboardCommand()
command! -range CopySelectionToClipboard call CopySelectionToClipboardCommand()
command! -range CopySelectionWithPathToClipboard call CopySelectionWithPathToClipboardCommand()
command! -range CopyWrappedSelectionWithPathToClipboard call CopyWrappedSelectionWithPathToClipboardCommand()
command! CopyFilePathWithLineToClipboard call CopyFilePathWithLineToClipboardCommand()

&cpoptions = cpoptions_save
