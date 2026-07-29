"" FILE: comment_tag_abbrev.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class CommentTagAbbrev
  def new()
    # 設定不要のため初期化のみ
  enddef

  # カーソル手前のコメントリーダー(#)有無を判定してタグコメントを返す
  # oやEnterで自動挿入された'#'が既にある場合は#を重ねず,無ければ'# 'を補う
  # hash_typedは'#=f'の形でアブレビの一部として'#'を打った場合に真となり,
  # その'#'は展開で消えるため既存リーダーの判定から除く
  def Expand(tag: string, hash_typed: bool): string
    var before = substitute(strpart(getline('.'), 0, col('.') - 1), this._TriggerPattern(hash_typed), '', '')

    if before !~# '#\s*$'
      return '# ' .. tag .. ':'
    endif

    var spaces = matchstr(before, '#\zs\s*$')

    if empty(spaces)
      return ' ' .. tag .. ':'
    endif

    # oやEnterが前行から引き継いだ整列用の空白は空白1つまで詰める
    return repeat("\<BS>", len(spaces) - 1) .. tag .. ':'
  enddef

  # 展開時にバッファから取り除かれるアブレビ部分の正規表現
  def _TriggerPattern(hash_typed: bool): string
    if hash_typed
      return '#=[fq]$'
    endif

    return '=[fq]$'
  enddef
endclass

var comment_tag_abbrev = CommentTagAbbrev.new()

def g:ExpandCommentTag(tag: string, hash_typed: bool): string
  return comment_tag_abbrev.Expand(tag, hash_typed)
enddef

&cpoptions = cpoptions_save
