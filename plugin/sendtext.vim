command! -nargs=+ SendText :call sendtext#iTermSendNext("<args>")

command! SendTextCurrentLine :call sendtext#iTermSendNext(getline('.'))

" Literally `j` then SendTextCurrentLine
command! SendTextNextLine :execute "norm j:SendTextCurrentLine<CR>"

" Literally `k` then SendTextCurrentLine
command! SendTextPreviousLine :execute "norm k:SendTextCurrentLine<CR>"
