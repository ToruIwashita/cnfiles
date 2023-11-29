"" FILE: github.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

unlet g:openbrowser_github_select_current_line

fun! s:open_pull_request_from_sha() abort
  let l:default_branch = split(system('\git symbolic-ref --short refs/remotes/origin/HEAD'), "\n")[0]
  let l:sha = matchstr(getline('.'), '^\zs[0-9a-f]\{7,10\}\ze')
  let l:commit_message = split(system('\git log '.l:sha.'...'.l:default_branch.' --merges --oneline --reverse --ancestry-path | \grep "Merge pull request #" | \head -n 1'), "\n")[0]
  let l:pull_request_id = matchstr(split(l:commit_message, ' ')[4], '#\zs\(.*\)\ze', 0)

  exec 'OpenGithubPullReq '.l:pull_request_id
endf

fun! s:open_pull_request_from_current_branch() abort
  let l:current_branch = split(system('\git rev-parse --abbrev-ref HEAD 2>/dev/null'), "\n")[0]

  exec 'OpenGithubPullReq #'.l:current_branch
endf

fun! s:github_setting() abort
  nnoremap <buffer> <C-s><C-g> :<C-u>OpenPullRequestFromSha<CR>
endf

command! OpenPullRequestFromSha call s:open_pull_request_from_sha()
command! OpenPullRequestFromCurrentBranch call s:open_pull_request_from_current_branch()

nnoremap <C-s>g :<C-u>OpenGithubProject<CR>
nnoremap <C-s>G :<C-u>OpenGithubFile<CR>y<CR>
nnoremap <C-s><C-g> :<C-u>OpenPullRequestFromCurrentBranch<CR>
vnoremap <C-s>G :<C-u>'<,'>OpenGithubFile<CR>y<CR>

augroup local_github
  autocmd!
  " fugitive.vim依存のコード
  autocmd FileType fugitiveblame call s:github_setting()
  " gv.vim依存のコード
  autocmd FileType GV call s:github_setting()
augroup END


let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
