## peco-ps
peco-ps() {
  local process_list_header process
  local -a processes

  process_list_header=$(ps -ef | head -1)
  processes=(${(f)"$(ps -ef | peco)"})

  print $process_list_header

  for process in $processes; do
    print $process
  done
}
