" FILE: git_diff_viewer.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class GitDiffViewer
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

    this._ExecuteGitDiff()
  enddef

  def _LoadConfig()
    this.config = {
      'git_command': 'git'
    }
  enddef

  def _ValidateConfig(): bool
    if !executable(this.config.git_command)
      echohl ErrorMsg
      echo 'Error: git command not found'
      echohl None
      return false
    endif

    # gitリポジトリ内にいるかの確認
    var git_check = system(this.config.git_command .. ' rev-parse --is-inside-work-tree 2>/dev/null')
    if v:shell_error != 0
      echohl ErrorMsg
      echo 'Error: Not in a git repository'
      echohl None
      return false
    endif

    return true
  enddef

  def _ExecuteGitDiff()
    var command = this.config.git_command .. ' diff'

    execute 'silent! !' .. command
    if v:shell_error != 0
      echohl ErrorMsg
      echo 'Error: Failed to execute git diff'
      echohl None
      return
    endif
    redraw!
  enddef
endclass

var git_diff_viewer = GitDiffViewer.new()

def GitDiffViewCommand()
  git_diff_viewer.View()
enddef

command! GitDiffView call GitDiffViewCommand()

&cpoptions = cpoptions_save
