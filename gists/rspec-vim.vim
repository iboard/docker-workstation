" Call rspec from vim
" Apr 21st, 2014 Andi Altendorfer <andreas@altendorfer.at>
"
" RspecLine() ... run rspec for the current cursor line
" RspecFile() ... run rspec for the current file
" RspecAll() .... run entire suite
"
" Copy this file to your ./vim/pluglin directory

function RspecLine()
  execute "!rspec -fd  %:" . line(".")
endfunction

function RspecFile()
  execute "!rspec -fd  %"
endfunction

function RspecAll()
  execute "!rspec -fd"
endfunction

nmap <c-j>rl :call RspecLine()<CR>
nmap <c-j>rf :call RspecFile()<CR>
nmap <c-j>ra :call RspecAll()<CR>
