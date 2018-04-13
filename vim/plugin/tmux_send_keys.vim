"" FILE: tmux_send_keys.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:tmux_call_prev_command() abort
  call job_start('tmux send-keys -t ! C-p C-j')
endf

command! TmuxCallPrevCommand call s:tmux_call_prev_command()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
