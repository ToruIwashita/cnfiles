"" FILE: github.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpo_save = &cpo
set cpo&vim

fun! s:open_pull_request_from_sha()
  let sha = matchstr(getline('.'), '\(^\zs[0-9a-f]\{7,10\}\ze\|\[\zs[0-9a-f]\{7,10\}\ze\]$\)')
  let commit_message = split(system('\git log '.sha.'...master --merges --oneline --reverse --ancestry-path | \grep "Merge pull request #" | \head -n 1'), "\n")[0]
  let pull_request_id = matchstr(split(commit_message, ' ')[4], '#\zs\(.*\)\ze', 0)

  exec 'OpenGithubPullReq '.pull_request_id
endf

command! OpenPullRequestFromSha call s:open_pull_request_from_sha()

nnoremap <C-s>g :<C-u>OpenGithubProject<CR>
nnoremap <C-s><C-g> :<C-u>OpenGithubFile<CR>y<CR>
nnoremap <C-s>G :<C-u>OpenPullRequestFromSha<CR>

cnorea '<,'>G '<,'>OpenGithubFile

let &cpo = s:cpo_save
unlet s:cpo_save
