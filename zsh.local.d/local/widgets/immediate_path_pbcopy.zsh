## immediate-path-pbcopy
_immediate-path-pbcopy() {
  local cmd unquoted_arg_path expanded_arg_path raw_full_path real_full_path quoted_real_full_path
  local -a args

  if (( $#BUFFER )); then
    args=("${(z)BUFFER}")

    # ファイル存在チェック用にエスケープを解除
    unquoted_arg_path="${(Q)args[$#args]}"
    # BUFFER中の ~ は (z) でも (Q) でも展開されず,そのままだと $PWD 配下として解決され存在チェックに失敗する
    expanded_arg_path="${unquoted_arg_path/#\~\//$HOME/}"

    if [[ "${expanded_arg_path}" = /* ]]; then
      real_full_path="${expanded_arg_path:A}"
    else
      raw_full_path="${PWD}/${expanded_arg_path}"
      real_full_path="${raw_full_path:A}"
    fi

    if [[ ! -e "$real_full_path" ]]; then
      zle beginning-of-line
      return
    fi

    # フルパスをエスケープ付きでクリップボードにコピー
    quoted_real_full_path="${(q)real_full_path}"
    cmd="echo -n ${(q)${quoted_real_full_path/#$HOME/~}} | pbcopy"
  else
    cmd="echo -n ${(q)${PWD/#$HOME/~}} | pbcopy"
  fi

  zle -I
  print -s ${(q)cmd} && eval $cmd
  print "copied to clipboard: $(pbpaste)"
}

zle -N immediate-path-pbcopy _immediate-path-pbcopy
