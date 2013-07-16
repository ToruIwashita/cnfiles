"" 各種設定読込
" 基本設定
source ~/.vim/vconf

" その他設定読み込み
let directories = ["abbreviate/","abbreviate_local/","macro/","macro_local/"]
for $dir in directories
  let $dir_path = "~/.vim/".$dir
  for $file in split(system("ls ".$dir_path),"\n")
    let $file_path = $dir_path.$file
    source $file_path
  endfor
endfor
