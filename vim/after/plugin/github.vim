"" FILE: github.vim
set encoding=utf-8
scriptencoding utf-8

let s:cpoptions_save = &cpoptions
set cpoptions&vim

fun! s:open_pull_request_from_sha()
  let l:sha = matchstr(getline('.'), '\(^\zs[0-9a-f]\{7,10\}\ze\|\[\zs[0-9a-f]\{7,10\}\ze\]$\)')
  let l:commit_message = split(system('\git log '.l:sha.'...master --merges --oneline --reverse --ancestry-path | \grep "Merge pull request #" | \head -n 1'), "\n")[0]
  let l:pull_request_id = matchstr(split(l:commit_message, ' ')[4], '#\zs\(.*\)\ze', 0)

  exec 'OpenGithubPullReq '.l:pull_request_id
endf

command! OpenPullRequestFromSha call s:open_pull_request_from_sha()

nnoremap <C-s>g :<C-u>OpenGithubProject<CR>
nnoremap <C-s>G :<C-u>OpenGithubFile<CR>y<CR>
vnoremap <C-s>G :<C-u>'<,'>OpenGithubFile<CR>y<CR>

fun! s:github_setting()
  nnoremap <buffer> <C-s><C-g> :<C-u>OpenPullRequestFromSha<CR>
endf

augroup local_github
  autocmd!
  " fugitive.vim依存のコード
  autocmd FileType fugitiveblame call s:github_setting()
  " gitv.vim依存のコード
  autocmd FileType gitv call s:github_setting()
augroup END


let &cpoptions = s:cpoptions_save
unlet s:cpoptions_save
