# VIM Send Text

SendText-like support for running Vim with iTerm2

https://github.com/wch/SendText

## What is it?

<img src='https://raw.githubusercontent.com/ddrscott/vim-islime2/gh-pages/demo.gif'/>

It lets you send commands from Vim to an iTerm2 session. This is handy if you
need to run a command repeatedly (like a test) and want to see the output. This
is especially nice in text-mode Vim, but it works fine from MacVim's GUI too.

It works by using AppleScript to switch to the next iTerm2 Pane (using `Cmd+]`),
writing the appropriate text then switching back (using `Cmd+[`).


## Usage

### For any commands

* `:SendText echo hi mom` - runs "echo hi mom"

## Recommended Mappings

```vim
let g:sendtext_iterm_older_29=1

" Send current line
nnoremap <silent> <Leader>i<CR> :SendTextCurrentLine<CR>

" Move to next line then send it
nnoremap <silent> <Leader>ij :SendTextNextLine<CR>

" Move to previous line then send it
nnoremap <silent> <Leader>ik :SendTextPreviousLine<CR>

" Send in/around text object - operation pending
nnoremap <silent> <Leader>i :set opfunc=sendtext#iTermSendOperator<CR>g@

" Send visual selection
vnoremap <silent> <Leader>i :<C-u>call sendtext#iTermSendOperator(visualmode(), 1)<CR>
```

## Thanks

* [Mat Schaffer](https://github.com/matschaffer/vim-islime2) for initial vim-islime2 project.
