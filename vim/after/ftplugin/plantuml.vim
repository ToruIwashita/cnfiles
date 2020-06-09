"" FILE: plantuml.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

let g:plantuml_previewer#save_format = 'svg'

augroup local_markdown
  autocmd!
  autocmd BufWritePost *.uml PlantumlSave
augroup END

nnoremap <C-s>v :<C-u>w<CR>:PlantumlOpen<CR>

cnorea PS PlantumlSave

let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
