" Call rspec from vim
" Apr 21st, 2014 Andi Altendorfer <andreas@altendorfer.at>, License MIT
"
" RunCurrentLine() ... evaluate current line with ruby-interpreter and append " output to the end of the line
" RunCurrentFile() ... evaluate current file with ruby-interpreter and append " output to the end of the file
"
" Copy this file to your ./vim/pluglin directory
function! RunCurrentLine ()
   exec "normal! $F#D"
   let _current_line = getline(".")
   let _cmd = matchstr( _current_line, '^puts' )
   let cmd = _current_line
   if empty(_cmd)
     let cmd = "puts " . _current_line
   endif
   exec "r! ruby -e"  . shellescape( cmd )
   exec "normal! kA # => \eJ"
endfunction

function! RunCurrentFile ()
  exec "normal! :$\no__END__\n\e"
  exec "normal! :0\n/^__END__$\nVGxo__END__\n\e"
  let cmd = expand('%:p')
  exec "r! ruby " . shellescape(cmd)
endfunction

map <c-j>rb :call RunCurrentLine()<CR>
map <c-j>rB :call RunCurrentFile()<CR>