"" FILE: deoplete.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

" オムニ補完用設定
set completeopt+=noselect

" オムニ補完の関数を呼び出しキーワードパターン設定
call deoplete#custom#option('omni_patterns', {
  \ 'ruby': ['[^. *\t]\.\w*', '[a-zA-Z_]\w*::']
\ })

" ポップアップメニューで表示される候補の数
call deoplete#custom#option({
  \ 'auto_complete_delay': 0,
  \ 'camel_case': v:false,
  \ 'ignore_case': v:false,
  \ 'smart_case': v:false,
  \ 'max_list': 30,
\ })

"" neocomplete key-mappings
" Ctr+Gで補完キャンセル&ポップアップを閉じる
inoremap <expr> <C-g> deoplete#close_popup()
" <TAB>で補完候補移動(下)
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <TAB>で補完候補移動(上)
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

"" 補完ポップアップメニュー色設定
" 補完メニューの全てのアイテム
hi Pmenu      ctermbg=45
" 選択しているアイテム
hi PmenuSel   ctermbg=85
" スクロールバー
hi PmenuSbar  ctermbg=75
" スクロールバーのレバー
hi PmenuThumb ctermbg=115

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
