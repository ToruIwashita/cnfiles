"" FILE: comment_tag_abbrev.vim

vim9script

var cpoptions_save = &cpoptions
set cpoptions&vim

class CommentTagAbbrev
  def new()
    # 設定不要のため初期化のみ
  enddef

  # カーソル手前のコメントリーダー(#)有無を判定してタグコメントを返す
  # oやEnterで自動挿入された'#'後の整列用空白は,挿入前に標準の空白1つへ正規化する
  # hash_typedは'#=f'の形でアブレビの一部として'#'を打った場合に真となり,
  # その'#'は展開で消えるため既存リーダーの判定から除く
  def Expand(tag: string, hash_typed: bool): string
    var before = substitute(strpart(getline('.'), 0, col('.') - 1), this._TriggerPattern(hash_typed), '', '')

    if before !~# '#\s*$'
      return '# ' .. tag .. ':'
    endif

    # バックスペースで空白を削ると,設定によっては行頭のインデントまで
    # 削除される。タグを入力してからコメントリーダーだけを直接正規化する。
    return tag .. ":\<C-o>:call setline('.', substitute(getline('.'), '#" .. '\s*' .. tag .. ":', '# " .. tag .. ":', ''))\<CR>"
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
