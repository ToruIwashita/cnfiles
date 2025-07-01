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

    execute ':w !pbcopy'
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
    var start_line = line("'<")
    var end_line = line("'>")
    var start_col = col("'<")
    var end_col = col("'>")

    if start_line == 0 || end_line == 0
      return {
        'content': '',
        'start_line': 0,
        'end_line': 0
      }
    endif

    var lines = getline(start_line, end_line)
    if empty(lines)
      return {
        'content': '',
        'start_line': start_line,
        'end_line': end_line
      }
    endif

    # 選択範囲の調整
    if len(lines) == 1
      # 単一行の場合
      var line_content = lines[0]
      if start_col <= end_col
        lines[0] = line_content[start_col - 1 : end_col - 1]
      endif
    else
      # 複数行の場合
      if start_col > 1
        lines[0] = lines[0][start_col - 1 :]
      endif
      if end_col < len(lines[-1])
        lines[-1] = lines[-1][: end_col - 1]
      endif
    endif

    return {
      'content': join(lines, "\n"),
      'start_line': start_line,
      'end_line': end_line
    }
  enddef

  def _FormatSelectionWithPath(content: string, file_path: string, start_line: number, end_line: number): string
    var line_range = start_line == end_line ? string(start_line) : start_line .. '-' .. end_line
    return '@' .. file_path .. ':' .. line_range .. "\n\n" .. content
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

def CopySelectionWithPathToClipboardCommand()
  pbcopy_manager.CopySelectionWithPathToClipboard()
enddef

command! CopyBufferToClipboard call CopyBufferToClipboardCommand()
command! CopyFilePathToClipboard call CopyFilePathToClipboardCommand()
command! -range CopySelectionWithPathToClipboard call CopySelectionWithPathToClipboardCommand()

&cpoptions = cpoptions_save
