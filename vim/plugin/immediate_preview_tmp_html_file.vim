"" FILE: immediate_preview_tmp_html_file.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class ImmediatePreviewTmpHtmlFile
  var config: dict<string>

  def new()
    this.config = {}
  enddef

  def OpenTmpHtmlFile()
    this._LoadConfig()

    if !this._ValidatePath(this.config.tmp_html_file_path)
      return
    endif

    this._OpenInBrowser(this.config.tmp_html_file_path)
  enddef

  def OpenTmpDumpHtmlFile()
    this._LoadConfig()

    if !this._ValidatePath(this.config.tmp_dump_html_file_path)
      return
    endif

    this._OpenInBrowser(this.config.tmp_dump_html_file_path)
  enddef

  def _LoadConfig()
    this.config = {
      'tmp_html_file_path': exists('g:memolist_tmp_html_file_path') ? g:memolist_tmp_html_file_path : '',
      'tmp_dump_html_file_path': exists('g:memolist_tmp_dump_html_file_path') ? g:memolist_tmp_dump_html_file_path : ''
    }
  enddef

  def _ValidatePath(path: string): bool
    if empty(path)
      echohl ErrorMsg | echo 'Error: html file path is not configured' | echohl None
      return false
    endif

    if !filereadable(path)
      echohl ErrorMsg | echo 'Error: html file not found: ' .. path | echohl None
      return false
    endif

    return true
  enddef

  def _OpenInBrowser(path: string)
    var command = 'open ' .. shellescape(path)

    execute 'silent! !' .. command

    if v:shell_error != 0
      echohl ErrorMsg | echo 'Error: Failed to open browser' | echohl None
      return
    endif

    redraw!
  enddef
endclass

var instance = ImmediatePreviewTmpHtmlFile.new()

def OpenTmpHtmlFileCommand()
  instance.OpenTmpHtmlFile()
enddef

def OpenTmpDumpHtmlFileCommand()
  instance.OpenTmpDumpHtmlFile()
enddef

command! ImmediatePreviewTmpHtmlFile call OpenTmpHtmlFileCommand()
command! ImmediatePreviewTmpDumpHtmlFile call OpenTmpDumpHtmlFileCommand()

&cpoptions = cpoptions_save
