" FILE: file_reload_manager.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class FileReloadManager
  def new()
    # 設定は実行時に読み込むため,ここでは初期化のみ
  enddef

  def ReloadAndNotify(message: string)
    # ファイルを強制的にリロード（変更は破棄）
    var msg_width = strdisplaywidth(message)

    # 現在のウィンドウの位置とサイズを取得
    var win_pos = win_screenpos(0)
    var win_height = winheight(0)
    var win_width = winwidth(0)

    # 現在のウィンドウの中央に表示するための座標計算
    var popup_line = win_pos[0] + (win_height / 2) - 2
    var popup_col = win_pos[1] + (win_width / 2) - (msg_width / 2)

    silent! edit!

    this._ShowNotification(message, popup_line, popup_col, msg_width)
  enddef

  def _ShowNotification(message: string, popup_line: number, popup_col: number, msg_width: number)
    popup_notification(message, {
      time: 1000,
      highlight: 'ModeMsg',
      line: popup_line,
      col: popup_col,
      padding: [0, 1, 0, 1],
      minwidth: msg_width,
      maxwidth: msg_width
    })
  enddef
endclass

var file_reload_manager = FileReloadManager.new()

# 後方互換性のための関数ラッパー
def ReloadAndNotifyCommand(message: string)
  file_reload_manager.ReloadAndNotify(message)
enddef

command! -nargs=1 ReloadAndNotify call ReloadAndNotifyCommand(<q-args>)

&cpoptions = cpoptions_save
