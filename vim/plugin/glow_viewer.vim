"" FILE: glow_viewer.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class GlowViewer
  var config: dict<string>

  def new()
    # 設定は実行時に読み込むため,ここでは初期化のみ
    this.config = {}
  enddef

  def View()
    this._LoadConfig()

    if !this._ValidateConfig()
      return
    endif

    this._ExecuteGlow()
  enddef

  def _LoadConfig()
    this.config = {
      'glow_command': 'glow'
    }
  enddef

  def _ValidateConfig(): bool
    var current_file = expand('%')
    if empty(current_file)
      echo 'No file currently open'
      return false
    endif

    # バッファが空の場合はチェック
    if line('$') == 1 && empty(getline(1))
      echohl ErrorMsg
      echo 'Error: Buffer is empty'
      echohl None
      return false
    endif

    # .mdファイルでない場合はglowコマンドのチェックをスキップ
    var file_extension = expand('%:e')
    if file_extension ==# 'md' && !executable(this.config.glow_command)
      echohl ErrorMsg
      echo 'Error: glow command not found'
      echohl None
      return false
    endif

    return true
  enddef

  def _ExecuteGlow()
    var current_file = expand('%')
    var file_extension = expand('%:e')

    var command: string
    if file_extension ==# 'md'
      command = 'cat ' .. shellescape(current_file) .. ' | ' .. this.config.glow_command .. ' --pager'
    else
      command = 'cat ' .. shellescape(current_file) .. ' | less'
    endif

    execute 'silent! !' .. command
    if v:shell_error != 0
      echohl ErrorMsg
      echo 'Error: Failed to execute command'
      echohl None
      return
    endif
    redraw!
  enddef
endclass

var glow_viewer = GlowViewer.new()

def GlowViewCommand()
  glow_viewer.View()
enddef

command! GlowView call GlowViewCommand()

&cpoptions = cpoptions_save
