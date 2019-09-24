"" FILE: tmux_send_keys.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:call_prev_command_on_tmux() abort
  call job_start('tmux send-keys -t ! C-p C-j')
endf

command! CallPrevCommandOnTmux call s:call_prev_command_on_tmux()

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
