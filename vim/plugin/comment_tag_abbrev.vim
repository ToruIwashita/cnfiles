"" FILE: comment_tag_abbrev.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class CommentTagAbbrev
  def new()
    # 設定不要のため初期化のみ
  enddef

  # カーソル手前のコメントリーダー(#)有無を判定してタグコメントを返す
  # oやEnterで自動挿入された'# 'が既にある場合は#を重ねず,無ければ'# 'を補う
  def Expand(tag: string): string
    var before = substitute(strpart(getline('.'), 0, col('.') - 1), '#\?=[fq]$', '', '')
    var leader = before =~# '#\s\+$' ? '' : '# '
    return leader .. tag .. ':'
  enddef
endclass

var comment_tag_abbrev = CommentTagAbbrev.new()

def g:ExpandCommentTag(tag: string): string
  return comment_tag_abbrev.Expand(tag)
enddef

&cpoptions = cpoptions_save
