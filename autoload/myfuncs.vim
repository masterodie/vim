" Delete Trailing Whitespace
function! myfuncs#DeleteTrailingWhitespace() abort
    if ! &bin
        silent! %s/\s\+$//ge
    endif
endfunction


" Recursively search up from dirname, sourcing all .vimrc.local files along the way
function! myfuncs#ApplyLocalSettings(dirname) abort
    " convert windows paths to unix style
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    " walk to the top of the dir tree
    let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
    if isdirectory(l:parentDir)
        call ApplyLocalSettings(l:parentDir)
    endif

    " now walk back down the path and source .vimsettings as you find them.
    " child directories can inherit from their parents
    let l:settingsFile = a:dirname . '/.vimrc.local'
    if filereadable(l:settingsFile)
        exec ':runtime' . l:settingsFile
    endif
endfunction

" Toggle relative number
function! myfuncs#NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

"Restore Last Cursor Position
function! myfuncs#RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

