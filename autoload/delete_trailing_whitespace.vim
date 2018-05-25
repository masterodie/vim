" Delete Trailing Whitespace
function! DeleteTrailingWS() abort
    if ! &bin
        silent! %s/\s\+$//ge
    endif
endfunction

