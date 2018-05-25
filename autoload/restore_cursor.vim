"Restore Last Cursor Position
function! RestoreCursor() abort
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

