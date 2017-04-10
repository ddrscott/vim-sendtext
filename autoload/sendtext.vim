function! sendtext#iTermRerun()
  if exists("g:islime2_last_command")
    call sendtext#iTermSendNext(g:islime2_last_command)
  else
    echoerr "No previous command. Try running a test first (with <leader>ft). Or you can store a command with `SendText my command`"
  endif
endfunction

function! sendtext#iTermSendUpEnter()
  call sendtext#iTermSendNext("OA")
endfunction

function! sendtext#iTermRunTest(file)
  if filereadable("script/test")
    call sendtext#iTermSendNext("script/test " . a:file)
  else
    echoerr "Couldn't execute " . getcwd() . "/script/test, please create test runner script."
  endif
endfunction

let s:current_file=expand("<sfile>")

" Sends the passed command to the next iTerm2 panel using Cmd+]
function! sendtext#iTermSendNext(command)
  let l:script_name = (exists('g:sendtext_iterm_older_29') && g:sendtext_iterm_older_29 == 1) ? 'run_command' : 'run_command29'

  let l:run_command = fnamemodify(s:current_file, ":p:h:h") . "/scripts/" . l:script_name . ".scpt"

  let g:islime2_last_command = a:command
  let l:mode = has('gui_running') ? 'gui' : 'terminal'
  call system("osascript " . l:run_command . " " . l:mode . " " . sendtext#shellesc(
        \ substitute(a:command, '\n$', '', '')))
endfunction

function! sendtext#shellesc(arg) abort
  return '"'.escape(a:arg, '"').'"'
endfunction

function! sendtext#iTermSendOperator(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let z=@z
  try
    if a:0  " Invoked from Visual mode, use gv command.
      silent exe "normal! gv\"zy"
    elseif a:type == 'line'
      silent exe "normal! '[V']\"zy"
    else
      silent exe "normal! `[v`]\"zy"
    endif
    call sendtext#iTermSendNext(@z)
  finally
    let &selection = sel_save
    let @z=z
  endtry
endfunction
